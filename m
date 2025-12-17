Return-Path: <linux-acpi+bounces-19636-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A70CC88EA
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 16:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D1413090115
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 15:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E6133DEFC;
	Wed, 17 Dec 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZT2c3zN0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AEC33B95B;
	Wed, 17 Dec 2025 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984616; cv=none; b=bMSYpQwZKXJ7qSjqaqZfjJ2oaYmg8cwdy/oAnEX3VjbfeitB0DhI9ZRD+iT3dw8VxU9bI3+7lzVczYh7kAKew896zcCZQQkgUYgIAVZZUKqQg2q16lXery4/XLcLwlz2uM4DzgsdwBw6kU2GviCgEaX5dcX/HegE0i6uIsVnAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984616; c=relaxed/simple;
	bh=Jn4ogLDd8r3CCYiLkWdVqZ7MN33WWwkMK5ahLaeXfh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HdaMa9dEZ4Cd7UkDwH6sF67KtEc4eQjdk15J8JYGK0rhpgTmt992cxsYn/QjHeQb/b/eJDMWjLBSkKdJWaosHrQ20Dg9XlMcNXzwuCFuIQL/spueGoDlUtDHQgz4z7qvU7r7wgbbOWKz2kD6vPhIhFWf7PbPpUHBX3/UF0Yp4t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZT2c3zN0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765984615; x=1797520615;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Jn4ogLDd8r3CCYiLkWdVqZ7MN33WWwkMK5ahLaeXfh4=;
  b=ZT2c3zN0+jkG+cG4d7YihGqlkSkh6sKoN1g6urNixWeKKhgHL+7Rm/CA
   mr9jkNcqDJD/ZeYiJWPZAX6aWsEN+u7PXbGgTTrxoBya6g3YDqiwNIVsp
   xBVZDq9n9CwyWGffdBwgHcJM1PLgQ7tPV1SS5R0GdBltmDD1pM35SgGXo
   jcjmJAQXXzlWdf7HzJ8ta8saIE4C5JzpXQcgCsAVyy9NEuT/G6r4lyBCe
   4eF6oaOvo51MNg9CBthCsdHh97gC2Lll82kklGF3OUkIGwgmOK5di3gOW
   kvKY98DZBJ95FzXcmvEJtAQX/CkkjsEr/pl7Fx7NaPi0/WG4UufVKx0yY
   g==;
X-CSE-ConnectionGUID: EIQ+wYwmQVGrWDCT21rYRA==
X-CSE-MsgGUID: rx4wt8CQQO2gW+q+7a64cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="71782192"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="71782192"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 07:16:54 -0800
X-CSE-ConnectionGUID: 9Zz3CuE/QJmSWpTPqvGO9A==
X-CSE-MsgGUID: FyV3p9PCScOjgZR8fF/CRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198326677"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Dec 2025 07:16:53 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVtGj-000000000pl-3LLX;
	Wed, 17 Dec 2025 15:16:49 +0000
Date: Wed, 17 Dec 2025 23:16:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 32/75] drivers/dma/sh/shdma-base.c:146:9:
 error: assigning to 'int' from incompatible type 'void'
Message-ID: <202512172351.Q3FbZRLS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   3c2d6399cecba91a426987e4fba035b21682335f
commit: f2729bf572500e3f9d4d5140129c72bd18942a17 [32/75] PM: runtime: Change pm_runtime_put() return type to void
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20251217/202512172351.Q3FbZRLS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251217/202512172351.Q3FbZRLS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512172351.Q3FbZRLS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/dma/sh/shdma-base.c:146:9: error: assigning to 'int' from incompatible type 'void'
     146 |                                 ret = pm_runtime_put(schan->dev);
         |                                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> sound/soc/rockchip/rockchip_sai.c:1491:2: error: statement requires expression of scalar type ('void' invalid)
    1491 |         if (pm_runtime_put(&pdev->dev))
         |         ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/watchdog/rzv2h_wdt.c:271:6: error: assigning to 'int' from incompatible type 'void'
     271 |         ret = pm_runtime_put(&pdev->dev);
         |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +146 drivers/dma/sh/shdma-base.c

9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   69  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   70  static dma_cookie_t shdma_tx_submit(struct dma_async_tx_descriptor *tx)
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   71  {
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   72  	struct shdma_desc *chunk, *c, *desc =
91ea74e9ec5c58 Kuninori Morimoto     2014-04-02   73  		container_of(tx, struct shdma_desc, async_tx);
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   74  	struct shdma_chan *schan = to_shdma_chan(tx->chan);
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   75  	dma_async_tx_callback callback = tx->callback;
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   76  	dma_cookie_t cookie;
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   77  	bool power_up;
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   78  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   79  	spin_lock_irq(&schan->chan_lock);
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   80  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   81  	power_up = list_empty(&schan->ld_queue);
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   82  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   83  	cookie = dma_cookie_assign(tx);
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   84  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   85  	/* Mark all chunks of this descriptor as submitted, move to the queue */
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   86  	list_for_each_entry_safe(chunk, c, desc->node.prev, node) {
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   87  		/*
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   88  		 * All chunks are on the global ld_free, so, we have to find
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   89  		 * the end of the chain ourselves
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   90  		 */
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   91  		if (chunk != desc && (chunk->mark == DESC_IDLE ||
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   92  				      chunk->async_tx.cookie > 0 ||
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   93  				      chunk->async_tx.cookie == -EBUSY ||
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   94  				      &chunk->node == &schan->ld_free))
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   95  			break;
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09   96  		chunk->mark = DESC_SUBMITTED;
91ea74e9ec5c58 Kuninori Morimoto     2014-04-02   97  		if (chunk->chunks == 1) {
91ea74e9ec5c58 Kuninori Morimoto     2014-04-02   98  			chunk->async_tx.callback = callback;
91ea74e9ec5c58 Kuninori Morimoto     2014-04-02   99  			chunk->async_tx.callback_param = tx->callback_param;
91ea74e9ec5c58 Kuninori Morimoto     2014-04-02  100  		} else {
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  101  			/* Callback goes to the last chunk */
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  102  			chunk->async_tx.callback = NULL;
91ea74e9ec5c58 Kuninori Morimoto     2014-04-02  103  		}
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  104  		chunk->cookie = cookie;
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  105  		list_move_tail(&chunk->node, &schan->ld_queue);
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  106  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  107  		dev_dbg(schan->dev, "submit #%d@%p on %d\n",
91ea74e9ec5c58 Kuninori Morimoto     2014-04-02  108  			tx->cookie, &chunk->async_tx, schan->id);
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  109  	}
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  110  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  111  	if (power_up) {
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  112  		int ret;
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  113  		schan->pm_state = SHDMA_PM_BUSY;
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  114  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  115  		ret = pm_runtime_get(schan->dev);
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  116  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  117  		spin_unlock_irq(&schan->chan_lock);
d143f939a95696 Vinod Koul            2022-03-10  118  		if (ret < 0)
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  119  			dev_err(schan->dev, "%s(): GET = %d\n", __func__, ret);
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  120  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  121  		pm_runtime_barrier(schan->dev);
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  122  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  123  		spin_lock_irq(&schan->chan_lock);
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  124  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  125  		/* Have we been reset, while waiting? */
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  126  		if (schan->pm_state != SHDMA_PM_ESTABLISHED) {
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  127  			struct shdma_dev *sdev =
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  128  				to_shdma_dev(schan->dma_chan.device);
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  129  			const struct shdma_ops *ops = sdev->ops;
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  130  			dev_dbg(schan->dev, "Bring up channel %d\n",
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  131  				schan->id);
d9a3e992945278 Thomas Andreatta      2025-08-27  132  
d9a3e992945278 Thomas Andreatta      2025-08-27  133  			ret = ops->setup_xfer(schan, schan->slave_id);
d9a3e992945278 Thomas Andreatta      2025-08-27  134  			if (ret < 0) {
d9a3e992945278 Thomas Andreatta      2025-08-27  135  				dev_err(schan->dev, "setup_xfer failed: %d\n", ret);
d9a3e992945278 Thomas Andreatta      2025-08-27  136  
d9a3e992945278 Thomas Andreatta      2025-08-27  137  				/* Remove chunks from the queue and mark them as idle */
d9a3e992945278 Thomas Andreatta      2025-08-27  138  				list_for_each_entry_safe(chunk, c, &schan->ld_queue, node) {
d9a3e992945278 Thomas Andreatta      2025-08-27  139  					if (chunk->cookie == cookie) {
d9a3e992945278 Thomas Andreatta      2025-08-27  140  						chunk->mark = DESC_IDLE;
d9a3e992945278 Thomas Andreatta      2025-08-27  141  						list_move(&chunk->node, &schan->ld_free);
d9a3e992945278 Thomas Andreatta      2025-08-27  142  					}
d9a3e992945278 Thomas Andreatta      2025-08-27  143  				}
d9a3e992945278 Thomas Andreatta      2025-08-27  144  
d9a3e992945278 Thomas Andreatta      2025-08-27  145  				schan->pm_state = SHDMA_PM_ESTABLISHED;
d9a3e992945278 Thomas Andreatta      2025-08-27 @146  				ret = pm_runtime_put(schan->dev);
d9a3e992945278 Thomas Andreatta      2025-08-27  147  
d9a3e992945278 Thomas Andreatta      2025-08-27  148  				spin_unlock_irq(&schan->chan_lock);
d9a3e992945278 Thomas Andreatta      2025-08-27  149  				return ret;
d9a3e992945278 Thomas Andreatta      2025-08-27  150  			}
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  151  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  152  			if (schan->pm_state == SHDMA_PM_PENDING)
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  153  				shdma_chan_xfer_ld_queue(schan);
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  154  			schan->pm_state = SHDMA_PM_ESTABLISHED;
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  155  		}
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  156  	} else {
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  157  		/*
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  158  		 * Tell .device_issue_pending() not to run the queue, interrupts
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  159  		 * will do it anyway
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  160  		 */
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  161  		schan->pm_state = SHDMA_PM_PENDING;
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  162  	}
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  163  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  164  	spin_unlock_irq(&schan->chan_lock);
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  165  
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  166  	return cookie;
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  167  }
9a7b8e002e331d Guennadi Liakhovetski 2012-05-09  168  

:::::: The code at line 146 was first introduced by commit
:::::: d9a3e9929452780df16f3414f0d59b5f69d058cf dmaengine: sh: setup_xref error handling

:::::: TO: Thomas Andreatta <thomasandreatta2000@gmail.com>
:::::: CC: Vinod Koul <vkoul@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

