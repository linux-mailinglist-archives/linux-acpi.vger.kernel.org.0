Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA6C70CE8F
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 01:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjEVXNX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 May 2023 19:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjEVXNJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 19:13:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8D1118;
        Mon, 22 May 2023 16:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684797181; x=1716333181;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NQFVu+pwe3hnmxk1nVAak2j55/ku/lM5q+fVLkE5rqw=;
  b=B7xZTgm1kC1Rvbsx7O1SHZJJqVhhvFMjPW2ZZhaZ1mVHtLNwjRl//zHd
   /ZtinklTptUlqt5EwApDtMQ+Dk8eF9lPor1PnQ6vTywSryF3uVh09DeZW
   dqjbZF9omOxVC9GODF7GzcA2oQcPRrKrGvUKMW3GoGrCQ5CGSr9P+pAaN
   pfCmPEoqWPq6KoXK/cxNWUToufP+FiQT5KQKevrcGi6jcj+Q6e1YlcaOQ
   wDl0vlxR0eDkE6evm92SGD2GoE+y0hqM/zeUqTEcjEXwv3667XDWtRCIw
   457tERkeXRoDU5h591LA+okOQ9alTq80zIMFjGNYCY4+gDHR43NiI1LiB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="333432205"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="333432205"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 16:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="793509711"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="793509711"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 22 May 2023 16:13:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 16:13:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 16:13:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 16:13:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjrynCLZ/w4EVTpVFvslsNqWFtjhPJmX+ob9hKMQYwqWpTeGLW89n7mG2ATToHJaSmDpmo91J0rRYxMswG2bf6Y0SpMLp83biyT0XIJCzLdGjEe5OYvYqE9/xZJncrxMSDy5vTrv6CuWnfKhuLjBxb0AjvzwV2VU5jUn9dYGs5aNy1MZlw/zgVCct/nkD44mffQSOdwHbqrT4WlZRQu9g/nb8NtpZmfIyxXdAqjmgrdv5LBcqsl2gJGiVK5ZWKIjFX9CTOry6T+OMGcjr5hYT/HffCQhojH3B6UgQlq4qJLP5zFkVxjE94bYhRa89Td3sYra7jO6V7sYk7tVW8anaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTsWg0y+7HkwXaUqpc1LqDlSTQPJYLGT+1IFiHtXAWY=;
 b=k4yTf9B2rFDugjJj8RzsXVOyN+aVCHn0e861o4gwi0P/ZT/bFwgVHAtyQVdRufG05Z5eL71kcRvVMNjlT9WXtlDKl3kmYrowUKAbJIX/3fpQe6WhcS3sfkc6zcXTsNCAv0E1N6x7fveR6e7thnQwFiKyidu14tdsMJhlMoaIcf1P5v6CTXZwXszpEKXViD/hwH3+QfT/Zax92GtVD+9adyuYW12TLy8f6SVpE0QL7s+DF0iyqEmevpCyiY3WzI79reh30ffy0fXlCvxxu8xaDBZlSnxQbrF1fS8cxWBGVWG58X71404B/aXfCkN25zsXK6Hkd+WroP1hmB+y7+9f7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5107.namprd11.prod.outlook.com (2603:10b6:303:97::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 23:12:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 23:12:58 +0000
Date:   Mon, 22 May 2023 16:12:56 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2 2/4] acpi: tables: Add CDAT table parsing support
Message-ID: <646bf6f826ec8_33fb329437@dwillia2-xfh.jf.intel.com.notmuch>
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
 <168443478863.2966470.17477171378435115702.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168443478863.2966470.17477171378435115702.stgit@djiang5-mobl3>
X-ClientProxiedBy: BYAPR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:a03:100::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c2d449-e37c-4947-8470-08db5b1a1532
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUIWBaN2vHcQBpg/0R4QRKOcngj+lKt4fTMciR8NmFCw1i50GOf8zq5UWdKtkXR5CHW8EgHGxdKKyE93UzGCv5Ua5Fs9j6O7l00NklebM3Tv1vaF6O42utyMPzfGCJOKcYauDq7zqjfXJlEZM8xpzLZM9WlvMqg94e4UOeLj0PBQPXsEvKnaHs9CNuP5k2oJsMGwudVRZ+0JjdcyvA8ZprA4yOMcKTtVOpOqMzrzoBXK7ZaL+GCDsVpF+EwiAwriJ+MyydmohIPFnQ1CfYJHfmhtoN4Zd02YcMMojk2gHHTxs1OtYTWhSK7zwDN+FJYsyUFz1P89sJWhDJp6AxOi7JXbuvthmufDq+VXGSop8ItHgYFifOQ4UpGKE/kvT4y+/Rc8Lfh56b7TVpjuyi97vNnuDKPWIhX68S4wPn+9weGjYYVq9QpZwtw7eUgrjdtKUX5qypDUINvuPihWZToHfobjaONpZYlo9vvFpf/PW/cADASB+7K2MARw9UL8BkVq1/uYNtluEsGtaMAxMYCqxXZoeViG+XsmWCSUy3DSR1L5LR8l65CAvfwO8fyjY1ea
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(2906002)(66899021)(5660300002)(83380400001)(8676002)(8936002)(41300700001)(66556008)(66946007)(54906003)(66476007)(4326008)(316002)(6486002)(478600001)(26005)(6512007)(86362001)(82960400001)(9686003)(6506007)(186003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LTcfclNW2f28okmzhpMEYZE5ignVoyr0LZ60K4iLnylEEMVuM69OgFC4PFPJ?=
 =?us-ascii?Q?I9DiNKniF+s1MKr/wXFpoj1uOW/kS+bWwhg01Ku3oyQb6Pa69N/qSUmimHFm?=
 =?us-ascii?Q?lkYM4fy6n7zsg+gBpn86zGv31Cjv8pO+C1yNS0qMdo58njhVyq3NW/TpstkN?=
 =?us-ascii?Q?ry1McyPqVUn1xSG7bhW1294FTTciZSrH0r2ITzznMOSUOX6tZ1xu9VhMRuzv?=
 =?us-ascii?Q?XBK0jXUANgNMDLOqeBxUwzO1zch82Xw7TYRIctNjK7d1X7+QvDxKMx4a9nkJ?=
 =?us-ascii?Q?HPYlUGY17p3IiuGmlALeMDZgdI0cRCeJq6XE7jyGIhvMYbRMsyoQer/XlBBo?=
 =?us-ascii?Q?soQ41Beo4hNTYL1DYZ5rCFpd15SlNJs55OhEz6srJPAOtYkhwPekQeulyFTR?=
 =?us-ascii?Q?gg3NtFVbQ6Z2GzzTW7gzL5PVbYMe+wSoYhXnC9niufb1jFRWsUyeUd7Lzyc6?=
 =?us-ascii?Q?0MOBS2+r56HdC9GpgOC+KAUC9diWjupe+aRbMPDQM0C3Mj7Ijbn1cKd/iXjw?=
 =?us-ascii?Q?rSwBwr9e/V76DsnZQnsPdDCYTcBK5tbpNnM2q5Zwqxkzhy3MJ0KbT8c/zsGX?=
 =?us-ascii?Q?ZnlqDVAYB/1MRozrd7Aq86IvDhL0zFcyzcM5iGRdktJjkPDx7frLRNyjc0/W?=
 =?us-ascii?Q?NVrPtZqHzQawzTfo+YOOp+zOEkQvMk3z0ktcTbyITr4EJHE+4/o6aOm1uKyj?=
 =?us-ascii?Q?Ca5xXB2M8ikxYb4JEhCRhQT2T8ugPOkY3HGPICckkn4ofs5e7sjnFfOV09p8?=
 =?us-ascii?Q?/yKGah25fiBiMJAaYGfhgKqM1Wdl5XiNcadbOFYkRr6YEZ7/JfnPTq1+Vpsg?=
 =?us-ascii?Q?kNclNwiQzJVejeJRUZFUBTQ/Kj7OiLFZtIgltGz6qSsE8beKx/QbUgrwKNGb?=
 =?us-ascii?Q?pj2HHdbOO4Lf0OtIWNAPmblGDsgl3byzj0TkcOqMpu5aribjqLp2/Z3lbqhe?=
 =?us-ascii?Q?0HC30S/CbLQ3wBtnqHN4wIYHDwIdcnNFOQnjeW/sEizDKa8etLuVpYWk9Ggx?=
 =?us-ascii?Q?mstx84J1SFgzWAaADkISGKWTRMH2FNVvEZ+1cVa4ziA3o77ffkK0IOua6riD?=
 =?us-ascii?Q?w6VafL+etp/35IqsNH4kCQft6U7bSaGpTL2c1aIT7bLzzSfSslqjZjggqgT5?=
 =?us-ascii?Q?Se0R0llgHkLL7/KfP5Tn67CrLShcnv00zXrBBRPpXdGVyrs6cu/gQlSdyk2Z?=
 =?us-ascii?Q?Rg/bVvJDA/ERbVaweHiEMcl1xBkEsAFWQngQwOTAJnBBj8lfMmOFyRxttFbw?=
 =?us-ascii?Q?O2/L3pHxtDlSjnFHgsB60juKaeaG8Z7tme8Pvng864xJ1kia8cobOmQRqUTy?=
 =?us-ascii?Q?03uN7SKNoVaUWW6Ln84JLUhNb4MLSNpHnIs1f1QaY/MGdv5Bb+lB6sVP/xEb?=
 =?us-ascii?Q?2jpO+EvBD3or01PmWszhv3+ONmfllsNfJDaAM90HZ9A8Uj+FsvYc2O8JoHrO?=
 =?us-ascii?Q?kWIO5d1uH+Tl1hDpoBQJDVUA+Oo8aonDKYNm86YLpJ9/aoDyWuN/wxTXhDGx?=
 =?us-ascii?Q?1xbEQoMvTIKnK6pGxZ8/WpruOcl0eytsURYvhxYoYGt2CzrOdHt1Es/EQN77?=
 =?us-ascii?Q?b+fzXnvJdAxqcZrYtYI3lzKwCuOHjZFUx6AaNWmPAiTyQHxWSxweHjxqNw+w?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c2d449-e37c-4947-8470-08db5b1a1532
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 23:12:58.7622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMkCshK+zb1T0ELJtwN5KqksKUuNZ/tq20Cmg6gl3KL/YWLM4LsbZhs32kFNQfODLR7BtxrH2rHFwofIiOG7UgaDA0icVtYDc3wqyul+KVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5107
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> The CDAT table is very similar to ACPI tables when it comes to sub-table
> and entry structures. The helper functions can be also used to parse the
> CDAT table. Add support to the helper functions to deal with an external
> CDAT table, and also handle the endieness since CDAT can be processed by a
> BE host. Export a function cdat_table_parse() for CXL driver to parse
> a CDAT table.
> 
> In order to minimize ACPICA code changes, __force is being utilized to deal
> with the case of a big endien (BE) host parsing a CDAT. All CDAT data
> structure variables are being force casted to __leX as appropriate.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v2:
> - Make acpi_table_header and acpi_table_cdat a union. (Jonathan)
> - Use local var to make acpi_table_get_length() more readable. (Jonathan)
> - Remove ACPI_SIG_CDAT define, already defined.
> ---
>  drivers/acpi/tables.c     |    5 +++-
>  drivers/acpi/tables_lib.c |   52 ++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/acpi.h      |   22 +++++++++++++++++--
>  3 files changed, 72 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index cfc76efd8788..f7e1ea192576 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -241,8 +241,9 @@ int __init_or_acpilib acpi_table_parse_entries_array(
>  		return -ENODEV;
>  	}
>  
> -	count = acpi_parse_entries_array(id, table_size, table_header,
> -			proc, proc_num, max_entries);
> +	count = acpi_parse_entries_array(id, table_size,
> +					 (union table_header *)table_header,

I think the force cast can be cleaned up, more below...

> +					 proc, proc_num, max_entries);
>  
>  	acpi_put_table(table_header);
>  	return count;
[..]
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 57ffba91bfb5..4a5b40463048 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -22,11 +22,17 @@
>  #include <acpi/acpi.h>
>  
>  /* Table Handlers */
> +union table_header {
> +	struct acpi_table_header acpi;
> +	struct acpi_table_cdat cdat;
> +};

'table_header' seems too generic a name for a type in a header file
included as widely as acpi.h. How about 'union acpi_parse_header'?

Moreover I think the type-casting when calling the helpers might look
better with explicit type-punning showing the conversion from ACPI and
CDAT callers into the common parser. Something like the following folded
on top (only compile tested):

-- >8 --
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index f7e1ea192576..ef31232fdcfb 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -219,7 +219,7 @@ int __init_or_acpilib acpi_table_parse_entries_array(
 	char *id, unsigned long table_size, struct acpi_subtable_proc *proc,
 	int proc_num, unsigned int max_entries)
 {
-	struct acpi_table_header *table_header = NULL;
+	union acpi_convert_header hdr;
 	int count;
 	u32 instance = 0;
 
@@ -235,17 +235,16 @@ int __init_or_acpilib acpi_table_parse_entries_array(
 	if (!strncmp(id, ACPI_SIG_MADT, 4))
 		instance = acpi_apic_instance;
 
-	acpi_get_table(id, instance, &table_header);
-	if (!table_header) {
+	acpi_get_table(id, instance, &hdr.acpi);
+	if (!hdr.acpi) {
 		pr_debug("%4.4s not present\n", id);
 		return -ENODEV;
 	}
 
-	count = acpi_parse_entries_array(id, table_size,
-					 (union table_header *)table_header,
-					 proc, proc_num, max_entries);
+	count = acpi_parse_entries_array(id, table_size, hdr.parse, proc,
+					 proc_num, max_entries);
 
-	acpi_put_table(table_header);
+	acpi_put_table(hdr.acpi);
 	return count;
 }
 
diff --git a/drivers/acpi/tables_lib.c b/drivers/acpi/tables_lib.c
index 71e2fb1735e5..bd886900762a 100644
--- a/drivers/acpi/tables_lib.c
+++ b/drivers/acpi/tables_lib.c
@@ -105,7 +105,7 @@ static enum acpi_subtable_type acpi_get_subtable_type(char *id)
 }
 
 static unsigned long acpi_table_get_length(enum acpi_subtable_type type,
-					   union table_header *hdr)
+					   union acpi_parse_header *hdr)
 {
 	if (type == CDAT_SUBTABLE) {
 		__le32 length = (__force __le32)hdr->cdat.length;
@@ -155,7 +155,7 @@ static int call_handler(struct acpi_subtable_proc *proc,
  * Otherwise, -ENODEV or -EINVAL is returned.
  */
 int acpi_parse_entries_array(char *id, unsigned long table_size,
-			     union table_header *table_header,
+			     union acpi_parse_header *table_header,
 			     struct acpi_subtable_proc *proc,
 			     int proc_num, unsigned int max_entries)
 {
@@ -224,6 +224,7 @@ int cdat_table_parse(enum acpi_cdat_type type,
 		     acpi_tbl_entry_handler_arg handler_arg, void *arg,
 		     struct acpi_table_cdat *table_header)
 {
+	union acpi_convert_header hdr = { .cdat = table_header };
 	struct acpi_subtable_proc proc = {
 		.id		= type,
 		.handler_arg	= handler_arg,
@@ -234,7 +235,7 @@ int cdat_table_parse(enum acpi_cdat_type type,
 		return -EINVAL;
 
 	return acpi_parse_entries_array(ACPI_SIG_CDAT,
-			sizeof(struct acpi_table_cdat),
-			(union table_header *)table_header, &proc, 1, 0);
+					sizeof(struct acpi_table_cdat),
+					hdr.parse, &proc, 1, 0);
 }
 EXPORT_SYMBOL_NS_GPL(cdat_table_parse, CXL);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index dcaaaffff318..40caea4ba227 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -25,11 +25,21 @@ struct irq_domain_ops;
 #include <acpi/acpi.h>
 
 /* Table Handlers */
-union table_header {
+union acpi_parse_header {
 	struct acpi_table_header acpi;
 	struct acpi_table_cdat cdat;
 };
 
+/*
+ * Perform type punning between ACPI and CDAT callers of the core table
+ * parsing routines that use acpi_parse_header internally
+ */
+union acpi_convert_header {
+	struct acpi_table_header *acpi;
+	struct acpi_table_cdat *cdat;
+	union acpi_parse_header *parse;
+};
+
 union acpi_subtable_headers {
 	struct acpi_subtable_header common;
 	struct acpi_hmat_structure hmat;
@@ -1539,7 +1549,7 @@ static inline void acpi_device_notify_remove(struct device *dev) { }
 
 #ifdef CONFIG_ACPI_TABLES_LIB
 int acpi_parse_entries_array(char *id, unsigned long table_size,
-			     union table_header *table_header,
+			     union acpi_parse_header *table_header,
 			     struct acpi_subtable_proc *proc,
 			     int proc_num, unsigned int max_entries);
 
@@ -1547,10 +1557,11 @@ int cdat_table_parse(enum acpi_cdat_type type,
 		     acpi_tbl_entry_handler_arg handler, void *arg,
 		     struct acpi_table_cdat *table_header);
 #else
-static inline int acpi_parse_entries_array(
-	char *id, unsigned long table_size,
-	union table_header *table_header, struct acpi_subtable_proc *proc,
-	int proc_num, unsigned int max_entries)
+static inline int
+acpi_parse_entries_array(char *id, unsigned long table_size,
+			 union acpi_parse_header *table_header,
+			 struct acpi_subtable_proc *proc, int proc_num,
+			 unsigned int max_entries)
 {
 	return -EOPNOTSUPP;
 }
