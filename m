Return-Path: <linux-acpi+bounces-280-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16257B2877
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 00:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A5B50283938
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 22:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA2719458
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 22:31:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFEF38DD8
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 22:26:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50175180;
	Thu, 28 Sep 2023 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695939999; x=1727475999;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4M/dahLhUbBKzNYghaLTW6oMoRm3cJLl1K9+PgdVjfw=;
  b=kteTX0Ifg8iSY9rkYMW8+C/3JLoxH9EW7ZsNxRg3XAUems9dxjjrkwuk
   F7QtbXvYxR4c/ttZ4W7zCr56QdHn+/sOQ8Y2y0doIWFPmQN45qipYe6Fn
   bzd/fSxDlAkbhrOodkjLMX2icWcmaTdftOdi7T2170+oujfcDVArMFraw
   uel2c/fddxX0B/7nT6g32V3mSQTmM+/68sRWAPY0l+FNrmFSM+hQasblc
   s0vTd9ags4EVWlE7mN8hQY+I/W4NR97u/N03fAgSXwjZhoFT4rs7pb8Z2
   t92zVitrmp+Zi5oR5dhEdgOnRojDMKL76LsYeTzdziWhqyXFjDgejvcGM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="413098985"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="413098985"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 15:26:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="699444311"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="699444311"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2023 15:26:36 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qlzSs-00023y-1t;
	Thu, 28 Sep 2023 22:26:34 +0000
Date: Fri, 29 Sep 2023 06:26:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>
Subject: [rafael-pm:bleeding-edge 86/94] drivers/acpi/utils.c:427: warning:
 Function parameter or member 'list2' not described in
 'acpi_handle_list_equal'
Message-ID: <202309290642.18zicoLj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   2cff74feed4a2a3a1c220e0ee2838b85b08d4999
commit: 2f5042ef239e43d2b02f7724714673e5e604bd6f [86/94] ACPI: utils: Dynamically determine acpi_handle_list size
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230929/202309290642.18zicoLj-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309290642.18zicoLj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309290642.18zicoLj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/utils.c:427: warning: Function parameter or member 'list2' not described in 'acpi_handle_list_equal'
>> drivers/acpi/utils.c:427: warning: Excess function parameter 'List2' description in 'acpi_handle_list_equal'


vim +427 drivers/acpi/utils.c

   416	
   417	/**
   418	 * acpi_handle_list_equal - Check if two ACPI handle lists are the same
   419	 * @list1: First list to compare.
   420	 * @List2: Second list to compare.
   421	 *
   422	 * Return true if the given ACPI handle lists are of the same size and
   423	 * contain the same ACPI handles in the same order.  Otherwise, return false.
   424	 */
   425	bool acpi_handle_list_equal(struct acpi_handle_list *list1,
   426				    struct acpi_handle_list *list2)
 > 427	{
   428		return list1->count == list2->count &&
   429			!memcmp(list1->handles, list2->handles,
   430			        list1->count * sizeof(acpi_handle));
   431	}
   432	EXPORT_SYMBOL_GPL(acpi_handle_list_equal);
   433	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

