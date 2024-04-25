#ifndef _LINUX_SLAB_DEF_H
#define	_LINUX_SLAB_DEF_H

#include <linux/reciprocal_div.h>

/*
 * Definitions unique to the original Linux SLAB allocator.
 */

/**
 * slab描述符
 * 高速缓存描述符
 * 1. 每一个高速缓存都是用kmem_cache结构来表示
 * 2. 高速缓存又被划分为slab，slab由一个或多个物理上连续的页组成。在数据结构上如何体现？
 * 3. 每个高速缓存可以由多个slab组成，在数据结构上如何体现？
 * 
 * 請注意：
 *   a. slab描述符要么在slab之外另行分配，要么放在slab自身开始的地方。
 */
struct kmem_cache {
	// 一个per-cpu的struct array_cache数据结构，每个CPU一个，表示本地CPU的对象缓冲池
	struct array_cache __percpu *cpu_cache;

/* 1) Cache tunables. Protected by slab_mutex */
	// 表示当前cpu的本地对象缓冲池array_cache为空时，从共享的缓冲池或者slabs_partial/slabs_fee列表中获取对象的数量
	unsigned int batchcount;
	// [阈值] 当本地对象缓冲池的空闲对象数目大于limit时就会主动释放batchcount个对象，以便内核回收和销毁slab
	unsigned int limit;
	// 用于多核系统，具体作用待补充
	unsigned int shared;

    // 对象的长度，这个长度需要加上align对齐字节
	unsigned int size;

	struct reciprocal_value reciprocal_buffer_size;
/* 2) touched by every alloc & free from the backend */
    // 对象的分配掩码
	unsigned int flags;		/* constant flags */
	// 一个slab中最多可以有多少个对象
	unsigned int num;		/* # of objs per slab */

/* 3) cache_grow/shrink */
	/* order of pgs per slab (2^n) */
	// 一个slab中占用2^gfporder个页面
	unsigned int gfporder;

	/* force GFP flags, e.g. GFP_DMA */
	gfp_t allocflags;

    // 着色(一个slab中有几个不同的cache line)
	size_t colour;			/* cache colouring range */
	//  一个cache colour 的长度
	unsigned int colour_off;	/* colour offset */

	struct kmem_cache *freelist_cache;
	// 
	unsigned int freelist_size;

	/* constructor func */
	/**
	 * 创建slab时用于初始化每个对象的构造函数，低版本内核中还有析构函数。
	 */
	void (*ctor)(void *obj);

/* 4) cache creation/removal */
	// 缓冲区名字
	const char *name;
	// 包含所有缓冲区描述结构的双向循环列表，队列头为slab_caches
	struct list_head list;
    // slab描述符引用次数？
	int refcount;
	// slab描述符缓存的对象所占内存的大小
	int object_size;
	// 对齐长度
	int align;

/* 5) statistics */
#ifdef CONFIG_DEBUG_SLAB
	unsigned long num_active;
	unsigned long num_allocations;
	unsigned long high_mark;
	unsigned long grown;
	unsigned long reaped;
	unsigned long errors;
	unsigned long max_freeable;
	unsigned long node_allocs;
	unsigned long node_frees;
	unsigned long node_overflow;
	atomic_t allochit;
	atomic_t allocmiss;
	atomic_t freehit;
	atomic_t freemiss;

	/*
	 * If debugging is enabled, then the allocator can add additional
	 * fields and/or padding to every object. size contains the total
	 * object size including these internal fields, the following two
	 * variables contain the offset to the user object and its size.
	 */
	int obj_offset;
#endif /* CONFIG_DEBUG_SLAB */

#ifdef CONFIG_MEMCG
	struct memcg_cache_params memcg_params;
#endif

    // 为每个节点创建的slab信息的数据结构
	struct kmem_cache_node *node[MAX_NUMNODES];
};

#endif	/* _LINUX_SLAB_DEF_H */
