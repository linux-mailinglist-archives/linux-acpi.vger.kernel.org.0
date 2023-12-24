Return-Path: <linux-acpi+bounces-2607-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C465781DCBB
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Dec 2023 22:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7D11F21BD8
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Dec 2023 21:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EB8FBEE;
	Sun, 24 Dec 2023 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3ZJcNin"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8A6EEDC;
	Sun, 24 Dec 2023 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703454039; x=1734990039;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TQQh45BiJQ6yfdgaV/qswu5XJQ1PRCWrbdcPw3s0/Kc=;
  b=C3ZJcNinJlV0hd4ESZhWSm8Mm1Xz5F1/7RchufHIIG6a3hGqzu6oE484
   WWZUVMq1Me9902zT/7EUvMorzq/3TCx69BloeF8hxLCQFiCpDcTQcQH8W
   dMXwEZm9RhN2l6Ow4QxMwd/HXUqW20ZvZ9hCaAggkAnPrSDnKQU0aB+sA
   gPjT3EhqIGJft/tcNDjint7L46o5Mrm2KX+sVb8Yf6JtLSxh+NwLx1KWk
   Te3fFSzvBYiujjl1nvsBofN1gvLuMORisy6a1/9zKAadTS0DGwZW3eNt2
   z0evdCYhLeaAJCE3VOwF8Qk9E+eKzf7CEhGgmycYdL21/Ynn/bsZFYRrS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="427418323"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="427418323"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 13:40:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="1024768283"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="1024768283"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Dec 2023 13:40:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Dec 2023 13:40:36 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Dec 2023 13:40:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 24 Dec 2023 13:40:35 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 24 Dec 2023 13:40:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEczTIvEcNRFnU7AErgYcOWthddT2FaIrT7wxQ+O8CzOuh6VovxI5afRuQb+q7ZSC+wPEpDKv3SpMg5Lk1aFAysnsYgZKA7kq08CFhI9jmDpR7JgOkg5x4j/Gq1O2BIEoZBYbyMC8DRQAtMTyEt4r57rOqpXBo+RXd8TE6Z1Vbm2r23WcEfNdMksHfKJenyqQlnsruXcLYBljxhSMgrOYJEbScMmNuukHl2EN7n80gThJdwIodC8FPOuFtAySiq+Dzww8uLiH+wnVnnwHit0p+3aWcquMj+mhCXqp7xX6yo97XVp++PS6maL7kmGg0731mmsKtMIs6vsJV0Ul77elg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQR5FjMNpw/N7lvoj/8Su4dwiNFT0RxMr8uR5SRBaPM=;
 b=iAiIijgcqV06wXIbAvLzD/Uj+REZqg/uMIwO/+M2CANbF7+yxIrdJq/HPjO7WE0LAxf7ab2SJ1m31az+ZY/q01TXe2VlN6+cY/RuWo+yLo5j+jKVpTdx3iEYoPz1VhxpXwAuS31UTblFAdrKiX4lVgU9IKHqdN9OrNG+N2sUNULDh4Qeb/yFYTBz0r3/IIBG09iknA2+kalk+lVNCmxLo8V1ow/RQOO3Vm05AVJEhn3oZI/Q5o+eZNFtfazQ3jHR4/xFMwZd6pKE+SdHskHDlCB+uIq8j8j3nUJzM2UDXDIyzqY6OOafojz47DfjEJ9OHw5O/CKsBNYmSg0UrqW+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6130.namprd11.prod.outlook.com (2603:10b6:a03:45f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 21:40:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7113.023; Sun, 24 Dec 2023
 21:40:32 +0000
Date: Sun, 24 Dec 2023 13:40:29 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: <linux-next@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Dave Jiang <dave.jiang@intel.com>, Yuntao Wang
	<ytcoode@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: FYI, cxl.git vs acpi.git conflict entering -next for v6.8
Message-ID: <6588a54d5c038_180129423@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:303:b5::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9461b1-ef9f-4033-b549-08dc04c8f46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWiLNj0lpTq0RU8lAx1WO/fagY0XTjSCThUao9HdA8wZ9gqnIMz4hin7ipz18vuxOjd7J6ciX9E/6Y4nFxgLBoWf2ici/lbdSl7dhjtSAB6z49gi91WixOChHQqVP12Z/c0xptjiTcN/MZnE916Mor7bVr5taVeQqIr1/WrrHObfRFqKMDWhNvB4+wsME4I10xXj1tnOxV5bKXMPo7iaFadhRn1kW8iwfRN7ODePWH4ATmzoGLTc+CRWnq6lw+lSm4hVeZoR7f/kNteeEd6gr+hfomwW2x6qWJvhL+pPR5S0tbDuwVnom8taK0J6OVff+g74UfGAaH0SO6JpuNGPJXOuC2Bf/HuS59ykPaK1ZEc3/S92JiQKpwImBj+Ea8FuWK0IpaBb1aLpsi+SNyOV6hJ7TzGQR0hf/IvJeFYDwQRdajdTbBgMg5t2pvKkm2nTaVzFbYsca49PrY6+9Wo/NYgr2qWwR/km8MB239nI/cDytS5m7hnsXbqStU4D0sYJ9Sa1BZ+lPtcufLu6dYeqH4MH4QwhDTvhQ5PHVc4vCIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8676002)(8936002)(5660300002)(4326008)(2906002)(478600001)(9686003)(6666004)(6506007)(6512007)(66556008)(66946007)(66476007)(54906003)(316002)(6916009)(6486002)(41300700001)(84970400001)(82960400001)(38100700002)(26005)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HqFFsskZdfTYW/5e+A9Dx06uLV6fB0eBEaK0HFU7O6SkQCIMUciAy9FrbStH?=
 =?us-ascii?Q?svqvbEN9oK0ItU0/U13bzubu98r5znyHj55SGDw2KmGXmlR4EehlW/YAI6Zb?=
 =?us-ascii?Q?+UpiCGfFQAVB7FuEMYYQkliGyBRWoChGkCzOIY7ICYTUpt2BW3G8vskIwn2Z?=
 =?us-ascii?Q?ViGCs7t25jHtIv3RXA/XvpRKA0joI70dOBeESoYw9JmbK53P0mAgAE5hiyXW?=
 =?us-ascii?Q?8fZYFF+qCh+zhN9oLn/Nsj5Hsp87QKhFkFVvt0jHHaCpc4I8DraxUgJ2Idx5?=
 =?us-ascii?Q?9Yko6c6kf8U9NtahkBtmqLa6umobx8UnRBvgzdIYZgaqQJR5wESCAywoK121?=
 =?us-ascii?Q?qC5Irj/QviDHqoVZzAAgd5brUXNOc/ioTZAEZheEYtGjT8AKjVYbaYJ3FITn?=
 =?us-ascii?Q?pZ84tYrJZgSbvImlOog3eo8vObAl2I7DdlMH62SHBmZOfv5bmT9FLfC7ldWo?=
 =?us-ascii?Q?MC/PSAfWKN4vINrctJ1ZoZ+7aXe2/n3kyBk0okAhyAGooEBk/b31veIiUJMS?=
 =?us-ascii?Q?VnB9ywaRtkwpoB2n3QVJX+GHJ/ypfqqSUfKtXxgKMfQADBEvldPfU+/IG3wI?=
 =?us-ascii?Q?g4TbDs+ExWnYVSErnK69JScavNvBr8Yak7OyUJhLpol5RXC0wwOmjaG/R5eq?=
 =?us-ascii?Q?t6Paf3f/wongmtswUvcvFvkIXwObx/toipQmUoS6LwFi8gDK1N95hUWWqfBl?=
 =?us-ascii?Q?ynbzsK+ZqDeGs/HreZaJdn7Jmlus00UBhRb1LvilzbwN7J2pYvPsO6hLMAlK?=
 =?us-ascii?Q?dc0i75Ieux2mXh3t8USyZv5BdLWGQRvTVWoe+YvZF7Hy9RDBbazOj942zvIF?=
 =?us-ascii?Q?0gXTx97IXNSoxAt9HpbF1aZgo/5ru5XsOSwe2pDtvEUsLjSSWbwgSag+UXy5?=
 =?us-ascii?Q?5fpexEt9JolCh+YI2Uk1izeebRyMDpna+/MVmT+NFjbf9UrWTFibvo27CdLU?=
 =?us-ascii?Q?dGJ3ktByA/aNEl8+qY3izZSVmY8xNhoWBr7pSyo712Lb03K2OHv6tjtPut22?=
 =?us-ascii?Q?Op6L+GaDHOJLz7OW4YM4zld7QK/Zjf+qNp6gCT2H+TvtottzHnszgbQANTp+?=
 =?us-ascii?Q?4HAgMayVmaVs96bKQQmuBC8Xu/z1yz5O48K0dIQKDcBWCFSLEhd8GF+czQxx?=
 =?us-ascii?Q?HNv4XgvrcMh/IzPhRIXijw2up+J+sOmCXtRcPbOJN8lEakHfZJSLCQvXUXw4?=
 =?us-ascii?Q?XH5T7fxFK7CqHm3kX/LeAW9wIXGPkHJgO2gwMivQVy4o/cceogBBMUlX+gdm?=
 =?us-ascii?Q?cCA0AlIeezPcZS2VN3oAMx6rEJ6T2oh7zSHv151SCci2rIgD6yxv9/zxGdUg?=
 =?us-ascii?Q?nP04TNqUlyo0mFGN+1vajs3CpXwO3gHzVm8G78E9/nC4H9cB26/On6EOTEiB?=
 =?us-ascii?Q?fUaxWXbHlDAc9rJbwHJukcy4d6KR0PHrC4E2O338PBElV0HbFlMP1ho4GVBd?=
 =?us-ascii?Q?TNtQJXdw+BBA9mqjsLFVyVtMONatGX8Rd7hbiDsnw6k4pHsd/E6hu2lRovyD?=
 =?us-ascii?Q?G6ElmYjjI0wc4ThkDXA5pCX9OnSPTkM1JvjltE0YvF9YzQ795btlhckgh1ri?=
 =?us-ascii?Q?qmKSCYiYZWUAreQcm2getTxg7Q7E0k74wPpfqZkJ4H6bDS3bN1Rq7m/6obyB?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9461b1-ef9f-4033-b549-08dc04c8f46e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 21:40:32.3640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veITYCWLfSt4sVikFq95yK3BP74ZlyP+1DPO2mC7iXN0TMvqOp0WgCxTaGiedd5ml7Tv11ZN74cvtQtrsrRt6vnrPaUU6I1kzRbYrx5QArs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6130
X-OriginatorOrg: intel.com

Hey Stephen,

Just a heads up that you will see a conflict with current ACPI content
with the next pull of cxl.git/next tree.

Here are the commits in -next that conflict:

f47507988145 thermal: ACPI: Move the ACPI thermal library to drivers/acpi/
4b3805daaacb ACPI: tables: Correct and clean up the logic of acpi_parse_entries_array()

My proposed resolution below, and this branch has otherwise got a build
success notification from 0day.


commit 43d2e52a911396164845727e5d92f1d73c4ac195
Merge: 39676dfe5233 185c1a489f87
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Fri Dec 22 16:04:54 2023 -0800

    Merge branch 'for-6.8/cxl-cdat' into test

diff --cc include/linux/acpi.h
index 118a18b7ff84,8b0761c682f9..b7165e52b3c6
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@@ -424,13 -425,16 +425,23 @@@ extern int acpi_blacklisted(void)
  extern void acpi_osi_setup(char *str);
  extern bool acpi_osi_is_win8(void);
  
 +#ifdef CONFIG_ACPI_THERMAL_LIB
 +int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp);
 +int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp);
 +int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp);
 +int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
 +#endif
 +
+ #ifdef CONFIG_ACPI_HMAT
+ int acpi_get_genport_coordinates(u32 uid, struct access_coordinate *coord);
+ #else
+ static inline int acpi_get_genport_coordinates(u32 uid,
+ 					       struct access_coordinate *coord)
+ {
+ 	return -EOPNOTSUPP;
+ }
+ #endif
+ 
  #ifdef CONFIG_ACPI_NUMA
  int acpi_map_pxm_to_node(int pxm);
  int acpi_get_node(acpi_handle handle);
diff --cc lib/fw_table.c
index c49a09ee3853,1e5e0b2f7012..c3569d2ba503
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@@ -85,9 -98,27 +98,22 @@@ acpi_get_subtable_type(char *id
  	return ACPI_SUBTABLE_COMMON;
  }
  
- static __init_or_acpilib int call_handler(struct acpi_subtable_proc *proc,
- 					  union acpi_subtable_headers *hdr,
- 					  unsigned long end)
+ static unsigned long __init_or_fwtbl_lib
+ acpi_table_get_length(enum acpi_subtable_type type,
+ 		      union fw_table_header *header)
+ {
+ 	if (type == CDAT_SUBTABLE) {
+ 		__le32 length = (__force __le32)header->cdat.length;
+ 
+ 		return le32_to_cpu(length);
+ 	}
+ 
+ 	return header->acpi.length;
+ }
+ 
 -static __init_or_fwtbl_lib bool has_handler(struct acpi_subtable_proc *proc)
 -{
 -	return proc->handler || proc->handler_arg;
 -}
 -
+ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
+ 					    union acpi_subtable_headers *hdr,
+ 					    unsigned long end)
  {
  	if (proc->handler)
  		return proc->handler(hdr, end);
@@@ -127,10 -158,14 +153,13 @@@ acpi_parse_entries_array(char *id, unsi
  {
  	unsigned long table_end, subtable_len, entry_len;
  	struct acpi_subtable_entry entry;
+ 	enum acpi_subtable_type type;
  	int count = 0;
 -	int errs = 0;
  	int i;
  
- 	table_end = (unsigned long)table_header + table_header->length;
+ 	type = acpi_get_subtable_type(id);
+ 	table_end = (unsigned long)table_header +
+ 		    acpi_table_get_length(type, table_header);
  
  	/* Parse all entries looking for a match. */
  
@@@ -168,9 -209,31 +197,31 @@@
  	}
  
  	if (max_entries && count > max_entries) {
 -		pr_warn("[%4.4s:0x%02x] found the maximum %i entries\n",
 -			id, proc->id, count);
 +		pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
 +			id, proc->id, count - max_entries, count);
  	}
  
 -	return errs ? -EINVAL : count;
 +	return count;
  }
+ 
+ int __init_or_fwtbl_lib
+ cdat_table_parse(enum acpi_cdat_type type,
+ 		 acpi_tbl_entry_handler_arg handler_arg,
+ 		 void *arg,
+ 		 struct acpi_table_cdat *table_header)
+ {
+ 	struct acpi_subtable_proc proc = {
+ 		.id		= type,
+ 		.handler_arg	= handler_arg,
+ 		.arg		= arg,
+ 	};
+ 
+ 	if (!table_header)
+ 		return -EINVAL;
+ 
+ 	return acpi_parse_entries_array(ACPI_SIG_CDAT,
+ 					sizeof(struct acpi_table_cdat),
+ 					(union fw_table_header *)table_header,
+ 					&proc, 1, 0);
+ }
+ EXPORT_SYMBOL_FWTBL_LIB(cdat_table_parse);

