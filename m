Return-Path: <linux-acpi+bounces-11614-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8702A4919F
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 07:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98283189328A
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 06:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893E1C07D8;
	Fri, 28 Feb 2025 06:40:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BE423DE;
	Fri, 28 Feb 2025 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724826; cv=none; b=jgq+4F5QavgogqLKlM0Niwkj11ZMXTrV14PpkEtiZKZ6/kxY+63Arecw+AgGgaNJixLcrI47uwTIihUvynYt4fCeWQXaQX0o0E0iW9GkDuDTCDqBJslUa2lqkShTiL/z8kMe2Ey4mYduy3BNUcW5TVbjozLoG5fIce89Rb6ASnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724826; c=relaxed/simple;
	bh=n8Glppsg8MB3vg/iXTQ+KTDq9sCkUhLw+3Ulp6LTrHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hg+vQPW89tcRUxWm4LboR6mPigG9ztn/9zchUUahikHFkcAeqN1jbMMLkk5LpZuRHHuWF4FHrEHwpt5DJ8oo/p5kGxVK+r95XcUZqBj8Km78oMMip4l2qCA9z30NUU3P9PTGoicraK9DMI5Q5rJKqGtZ/AuQMP1Ya2wW08bHya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-39-67c15a52e4db
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: honggyu.kim@sk.com,
	gregkh@linuxfoundation.org,
	rakie.kim@sk.com,
	akpm@linux-foundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	kernel_team@skhynix.com
Subject: Re: [PATCH 1/2 v6] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Fri, 28 Feb 2025 15:39:55 +0900
Message-ID: <20250228064016.1325-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsXC9ZZnoW5Q1MF0g7e9shZz1q9hs5g+9QKj
	xYmbjWwWzYvXs1ms3uRrcbv/HKvFqoXX2CyOb53HbrHvIlDZzodv2SyW7+tntLi8aw6bxb01
	/1kt5n6ZyuzA53H4zXtmj52z7rJ7tBx5y+qxeM9LJo9NqzrZPDZ9msTucWLGbxaPhQ1TmT32
	z13D7nHuYoXH501yAdxRXDYpqTmZZalF+nYJXBn3dzUyF+yWqXh/Nq6B8ZloFyMnh4SAiUTz
	1ePsMPbOA8+YQGw2AQ2Jg4dOMoPYIgKaEidaJwHZXBzMAtOZJRofbGQFSQgLeEq0HVnJ2MXI
	wcEioCqxcrUXSJhXwFzi7/KJLBAzNSUaLt0Dm8kpYCfx8MhhNhBbSIBH4tWG/YwQ9YISJ2c+
	AatnFpCXaN46G2yXhEA7u8SxQ2ehjpOUOLjiBssERv5ZSHpmIelZwMi0ilEoM68sNzEzx0Qv
	ozIvs0IvOT93EyMwVpbV/onewfjpQvAhRgEORiUe3hNRB9KFWBPLiitzDzFKcDArifDOigUK
	8aYkVlalFuXHF5XmpBYfYpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRqYExw21175kX2
	7dpVM9QM3whP97SuqJu2akrL8pXRATneVh2r7z4u7pr+uJvl04IP2mtj+1peXjzs1eI/4cDy
	JS/mzBFarHL6prXcnri+3yoLj8We8C+MmX6GzTLj8L4TzqyqRox8K4/LLNR/IPLpWaCGUsH1
	LMc5dUn15xOT7eyjv2UwrmdfuUOJpTgj0VCLuag4EQDWmk3IkQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsXCNUNWRzco6mC6wc11vBZz1q9hs5g+9QKj
	xYmbjWwWzYvXs1ms3uRr8fnZa2aL2/3nWC1WLbzGZnF86zx2i30XgWoPzz3JarHz4Vs2i+X7
	+hktLu+aw2Zxb81/Vou5X6YyWxy69pzVQdDj8Jv3zB47Z91l92g58pbVY/Gel0wem1Z1snls
	+jSJ3ePEjN8sHgsbpjJ77J+7ht3j3MUKj2+3PTwWv/jA5PF5k1wAbxSXTUpqTmZZapG+XQJX
	xv1djcwFu2Uq3p+Na2B8JtrFyMkhIWAisfPAMyYQm01AQ+LgoZPMILaIgKbEidZJQDYXB7PA
	dGaJxgcbWUESwgKeEm1HVjJ2MXJwsAioSqxc7QUS5hUwl/i7fCILxExNiYZL98BmcgrYSTw8
	cpgNxBYS4JF4tWE/I0S9oMTJmU/A6pkF5CWat85mnsDIMwtJahaS1AJGplWMIpl5ZbmJmTmm
	esXZGZV5mRV6yfm5mxiBUbGs9s/EHYxfLrsfYhTgYFTi4T0RdSBdiDWxrLgy9xCjBAezkgjv
	rFigEG9KYmVValF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA+PcPzz9
	kT571rVcilWY+TbBKl3G7NpOLeZdLi0ndRq57Y+7n9v+7M8HyTVvd7VvU99qGhanNOFzz7fy
	DndHp4y4xT3R5xqPTnU6cN4vXFt9AS8v+8tKvytO8YYeEVHqbWzmGuYlyy528oQ7bbPqamzw
	UVh269Matc8SHJkqS1J/O64727L0ixJLcUaioRZzUXEiAGDzoLaGAgAA
X-CFilter-Loop: Reflected

Hi, Joshua. 

First of all I accidentally sent the wrong email a few hours ago.
Please disregard it. Sorry for the confusion.

On Wed, 26 Feb 2025 13:35:17 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

[...snip...]
>  
> +/*
> + * Convert bandwidth values into weighted interleave weights.
> + * Call with iw_table_lock.
> + */
> +static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
> +{
> +	u64 sum_bw = 0;
> +	unsigned int cast_sum_bw, sum_iw = 0;
> +	unsigned int scaling_factor = 1, iw_gcd = 1;
> +	int nid;
> +
> +	/* Recalculate the bandwidth distribution given the new info */
> +	for_each_node_state(nid, N_MEMORY)
> +		sum_bw += bw[nid];
> +
> +	for (nid = 0; nid < nr_node_ids; nid++) {
> +		/* Set memoryless nodes' weights to 1 to prevent div/0 later */
> +		if (!node_state(nid, N_MEMORY)) {
> +			new_iw[nid] = 1;
> +			continue;
> +		}
> +
> +		scaling_factor = 100 * bw[nid];
> +
> +		/*
> +		 * Try not to perform 64-bit division.
> +		 * If sum_bw < scaling_factor, then sum_bw < U32_MAX.
> +		 * If sum_bw > scaling_factor, then bw[nid] is less than
> +		 * 1% of the total bandwidth. Round up to 1%.
> +		 */
> +		if (bw[nid] && sum_bw < scaling_factor) {
> +			cast_sum_bw = (unsigned int)sum_bw;
> +			new_iw[nid] = scaling_factor / cast_sum_bw;
> +		} else {
> +			new_iw[nid] = 1;
> +		}
> +		sum_iw += new_iw[nid];
> +	}
> +
> +	/*
> +	 * Scale each node's share of the total bandwidth from percentages
> +	 * to whole numbers in the range [1, weightiness]
> +	 */
> +	for_each_node_state(nid, N_MEMORY) {
> +		scaling_factor = weightiness * new_iw[nid];
> +		new_iw[nid] = max(scaling_factor / sum_iw, 1);
> +		if (nid == 0)
> +			iw_gcd = new_iw[0];
> +		iw_gcd = gcd(iw_gcd, new_iw[nid]);
> +	}
> +
> +	/* 1:2 is strictly better than 16:32. Reduce by the weights' GCD. */
> +	for_each_node_state(nid, N_MEMORY)
> +		new_iw[nid] /= iw_gcd;
> +}

In my understanding, new_iw[nid] values are scaled twice, first to 100 and then to a 
weightines value of 32. I think this scaling can be done just once, directly 
to weightness value as follows:

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 50cbb7c047fa..65a7e2baf161 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -176,47 +176,22 @@ static u8 get_il_weight(int node)
 static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
 {
	u64 sum_bw = 0;
-	unsigned int cast_sum_bw, sum_iw = 0;
-	unsigned int scaling_factor = 1, iw_gcd = 1;
+	unsigned int scaling_factor = 1, iw_gcd = 0;
	int nid;

	/* Recalculate the bandwidth distribution given the new info */
	for_each_node_state(nid, N_MEMORY)
		sum_bw += bw[nid];

-       for (nid = 0; nid < nr_node_ids; nid++) {
 			[...snip...]
-		/*
-		 * Try not to perform 64-bit division.
-		 * If sum_bw < scaling_factor, then sum_bw < U32_MAX.
-		 * If sum_bw > scaling_factor, then bw[nid] is less than
-		 * 1% of the total bandwidth. Round up to 1%.
-		 */
 			[...snip...]
-		sum_iw += new_iw[nid];
-	}
-
     
	/*
	 * Scale each node's share of the total bandwidth from percentages
	 * to whole numbers in the range [1, weightiness]
	 */
	for_each_node_state(nid, N_MEMORY) {
-		scaling_factor = weightiness * new_iw[nid];
-		new_iw[nid] = max(scaling_factor / sum_iw, 1);
-		if (nid == 0)
-			iw_gcd = new_iw[0];
+		scaling_factor = weightiness * bw[nid];
+		new_iw[nid] = max(scaling_factor / sum_bw, 1);
+		if (!iw_gcd)
+			iw_gcd = new_iw[nid];
		iw_gcd = gcd(iw_gcd, new_iw[nid]);
	}

Please let me know how you think about this.

Best regards,
Yunjeong

