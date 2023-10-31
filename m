Return-Path: <linux-acpi+bounces-1120-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1107DD854
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 23:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A9C1C20C8D
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 22:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74A627446
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7jcHXbj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91350225D7;
	Tue, 31 Oct 2023 21:49:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDE8FE;
	Tue, 31 Oct 2023 14:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698788986; x=1730324986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=600Nvh60124lsqCSvHFqzYzSMSzi4J7+aWhMqXLTTIM=;
  b=C7jcHXbjXdZ4dp8esjDLBHLevhdh19Kn+cwqUKt3DuBs73fDDC3XVmnw
   XZ866IiTAyVtDvXlXkVlu+Ss+D/z9YR5WuJM76dOvvRn6wmgEFQkqZpD1
   4DuobhUNpJFlhjRsL5jz2lzd7IFVKE3wvTXlD2JClw/3cA1O1kc+SVPhG
   I/7u1fd2OpxWaheqmJ0IaQwtfBEProHSFFTL0WXu7SMipqYmVUFg4AEH+
   LHOtno9rpFZ8xu9Gx4DKXLxjBQ6DIJZkglZzZ/+7hN1jfVZdQsF7HgYVB
   VhaoK23e2n7IhGplBvMTGCWfZHBDhgcFCF/T0YiwVrGbVBXFL8OyaVbdD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="454850526"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="454850526"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 14:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="760748094"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="760748094"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 31 Oct 2023 14:49:42 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qxwcG-0000PI-0V;
	Tue, 31 Oct 2023 21:49:40 +0000
Date: Wed, 1 Nov 2023 05:49:33 +0800
From: kernel test robot <lkp@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-acpi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-media@vger.kernel.org,
	Paul Elder <paul.elder@ideasonboard.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Julien Stephan <jstephan@baylibre.com>, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] device property: Add fwnode_name_eq()
Message-ID: <202311010542.1tRHV0in-lkp@intel.com>
References: <20231031135306.1106640-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031135306.1106640-1-sakari.ailus@linux.intel.com>

Hi Sakari,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.6 next-20231031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sakari-Ailus/device-property-Add-fwnode_name_eq/20231031-224454
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20231031135306.1106640-1-sakari.ailus%40linux.intel.com
patch subject: [PATCH 1/1] device property: Add fwnode_name_eq()
config: sh-allnoconfig (https://download.01.org/0day-ci/archive/20231101/202311010542.1tRHV0in-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231101/202311010542.1tRHV0in-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311010542.1tRHV0in-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/property.c:611: warning: Function parameter or member 'fwnode' not described in 'fwnode_name_eq'


vim +611 drivers/base/property.c

   596	
   597	/**
   598	 * fwnode_name_eq - Return true if node name is equal
   599	 * @fwnode The firmware node
   600	 * @name: The name to which to compare the node name
   601	 *
   602	 * Compare the name provided as an argument to the name of the node, stopping
   603	 * the comparison to either '\0' or '@' character, whichever comes first. This
   604	 * function is generally used for comparing node names while ignoring the
   605	 * possible unit address of the node.
   606	 *
   607	 * Return: true if the node name matches with the name provided in the @name
   608	 * argument, false otherwise.
   609	 */
   610	bool fwnode_name_eq(const struct fwnode_handle *fwnode, const char *name)
 > 611	{
   612		const char *node_name;
   613		unsigned int len;
   614	
   615		node_name = fwnode_get_name(fwnode);
   616		if (!node_name)
   617			return false;
   618	
   619		len = strchrnul(node_name, '@') - node_name;
   620	
   621		return strlen(name) == len && !strncmp(node_name, name, len);
   622	}
   623	EXPORT_SYMBOL_GPL(fwnode_name_eq);
   624	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

