Return-Path: <linux-acpi+bounces-498-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2D07BC357
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 02:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9D51C2097D
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 00:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6FB15B5
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="P7sWbxiR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5E163
	for <linux-acpi@vger.kernel.org>; Sat,  7 Oct 2023 00:11:48 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2115.outbound.protection.outlook.com [40.107.212.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C40BF
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 17:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDggkNTsntU4mKPbHbNeoe0ZyLlIYdgUd0SvvpwyrcjLZhEzkiuD6ou9JzagcqyeMrZ/fP3O6fRn2ks49Hlmh3ixPvPnjTiyiSA4exu+FcaUagI4BqnHrmf0u2Lh++tagHsumEyhLxN5W3YPidnO+v9sn92kW59nZWM32ejm6mbiq/hdXKgcHHxXL+njKOEc2hsMxDzuJ+JUeNswm6ReRt5RBoW/2k6+lfmEGmy4QsANkV0f9z3HDzq9FeU8cIhezgQKJ9oqW7Xcj18EthmXFTszZ3NseALAzI2D63XuFyr5UvHM3xHcM5gnZagXgQYQPvbzq6Z6dzgQY/sHZ+SZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iGcyyKI+chgC3IjOz90PzT8qUGN+DW2+MdXcgVNEwM=;
 b=VPKuhgtM1/QwdeWK5+ARmGezHN5o/7OvT94VMefvDEAMzMfw82DF9dmmcVMbFE84O6gcSFewWOM6h2CQQTKRuSeEmboTgqcm0SiH+60C7qZXIBBDQI3tWgLDqmdjvvGkGqneHWCdyXtE2HnBZE+FtX8ke4E5ycFEZN4UtajkOcfLMkY8lseM9tbjRUtpg48oMVFV4UHR9PlgIeLh4E4j0MwLrfooykB0DTISPoBl2hhrdlb9/zLX7uVOIfvsWJgDYp2JRCw0n0g9h/J0YHooGzHh+3v6NrmVRaywehY515w5uVO1KzJiSfV647hVYGrtSNWQMvNNYV5dF5bLGN5L/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iGcyyKI+chgC3IjOz90PzT8qUGN+DW2+MdXcgVNEwM=;
 b=P7sWbxiRgd6ranGekSgMhF8CWM8qYgMWmC8hO3Y3hve7e22zwaKbshtr4Tbykvn3zQGcTtjoPEa/B22kzWxe/uigtZ3+pAzEVM7lSEPIVMIVar83v+oJ4LQZMuQDOcz0r/aNyF3XzXnqEcoR0L9ScAaIdrmd6UTT6c9EDUw1WHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 SN4PR01MB7405.prod.exchangelabs.com (2603:10b6:806:1e8::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.39; Sat, 7 Oct 2023 00:11:43 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::ac16:89d:a480:ed6e]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::ac16:89d:a480:ed6e%4]) with mapi id 15.20.6838.028; Sat, 7 Oct 2023
 00:11:43 +0000
From: D Scott Phillips <scott@os.amperecomputing.com>
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, "Rafael
 J . Wysocki" <rafael.j.wysocki@intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v2] ACPI: bus: Consolidate all arm specific
 initialisation into acpi_arm_init()
In-Reply-To: <20230606093531.2746732-1-sudeep.holla@arm.com>
References: <20230606093531.2746732-1-sudeep.holla@arm.com>
Date: Fri, 06 Oct 2023 17:11:39 -0700
Message-ID: <867cnzqojo.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:610:20::25) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|SN4PR01MB7405:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bd029a-9173-46ad-b38f-08dbc6c9fc69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A7E6dFXaMJ8gQBG4scqXeUpf1aAzkRnrePEmRq9Q6A0emJXPxqVDd/MAkATgqD53dM82XcHcE57Wt68l19roFRRFeaiI0dbs1bfb8DdJUBvvIO6EYqt+umoGidTer/45wwDj3ZEjmi6kO75ssQlXfb+XCJ+Rgb9B5TQU07Zgyt3teBH+mjz5yaqoZxQNM/MEFinVKVf3J8zXhcq+9H545cWbDhi8FcObVQXoDSG7fqSejEV6RnO2X1lQVvsn+5tAqUauqfcA/ZRI1o+clEENdLjtwodSxXeMO7RDJqyBTku/46Q3l1T2uR7qfpGo4GRQXpGKhLNUslfKMRdk0XFcqiqF87fcdVlNsQTdg6Y15GOGsk9idl5Kszok5SrYnIWpGPt53oqwg0psHNEJkNUYlw3zZtGgaj0kbkzok5sX8uYoVb1V/LF77lIcVIB3S3c0UwL4vs5vGVqH4xXW2lSNOBmM+02z+O7X9QX+FfBqZmItldY7pN00XdaVhBLQDrg38TJ/yPPm2+FGWXsk9loRkm/4HBeGRQYy0yldPlqF7ZYkKE3ItR2sBaPSo2LYC7LU64IK8oE1iLVRNg9DL4bZM578XVgePsV0/HEt06FnWfY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(366004)(346002)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6666004)(9686003)(6512007)(6506007)(6486002)(52116002)(478600001)(966005)(26005)(2906002)(316002)(41300700001)(66476007)(5660300002)(66946007)(66556008)(8936002)(8676002)(4326008)(54906003)(38350700002)(86362001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OBuMkY7N/RLQeNkVho0HsRSqYD2+k2E4Vds+FZSEMKbXfDRC16gYhhBA9ECZ?=
 =?us-ascii?Q?qtWoqS8g5yu6HLlkABDHjlzcJTL/EaJPXyirVpeOkJ2Yqo5PajVodf97FJjY?=
 =?us-ascii?Q?bJnzVZ/DB7Q8FFWlnBpiodYkHBYVaiUIeuJtVIz5CEVrYf1TJ/FNf+0KLwsE?=
 =?us-ascii?Q?bAxqML3omApgwxUGhPMMtEFArXOM+OaVuO4HyF5ppqEBqS4ZdkehTFicgycr?=
 =?us-ascii?Q?+cJyWkZh4egQXSeUTo6KvLpIgtx0+gpYSQfA8HK27st3taZuPOYPzUUF8cdy?=
 =?us-ascii?Q?JdO1X4E0mSYhNm/JU+H1Vh/i1ib0mumXV0rNdr5cKpqODm0hY3M+CFDPmI2S?=
 =?us-ascii?Q?3yyqlJ66Tnv6inY1lYm/Wcnf3ndP0Fg8fp/PM+VwMs5jLSXpu3TyG0zMPHtf?=
 =?us-ascii?Q?V9Z2fXvSr19zHfhl5cWcR56aPk/WJnSk1taitShvrRp4oFBq8VOBVZBfJU2A?=
 =?us-ascii?Q?DcIMrVYxMMzuDgiM7CmmnhrkEQRruelRtS2INmbRBA1sPI8yXVLK9u5G8PRo?=
 =?us-ascii?Q?tFQW+PfVuOWJBNEC3hrM35WyopWZCEb348n+Enh9zpW3ma6Jd9e5gqnhC4WA?=
 =?us-ascii?Q?oNtVeH4npM7rlKAuULl6jw5lZKzlLfPGcU2AeccjjnrfIeGwhxR3A05zKEPC?=
 =?us-ascii?Q?oKBR2UBakehQLb2+ZoRWpjHtHuAcwY7JyQqdMPJhZfGgsbRBVbVZzx88jYUU?=
 =?us-ascii?Q?/nasTnNgMpNhesWS99SrGvSA2ok7Wrn+wwKEfeghs7tXMWrrYXP7xkg0Dozo?=
 =?us-ascii?Q?r58HpDXvTln+2pYEoC5yTRfTjO32aIyaNQi9n3GzHnRN6Dd2lqatWh/ZC6wI?=
 =?us-ascii?Q?4RGC1Y8zOK77lU6wCgnrUBCv61V8cLWfcYo6tmRO/R8Ok+L4jp673mWqEIYz?=
 =?us-ascii?Q?R+4FC336g8RBHfQad32E9OAzmkY5l/zNJNoZla4INi0a7ldEHNiBEwLRGVpQ?=
 =?us-ascii?Q?em9Zsovm/Gac0I4FL6IyykgWiUH2r2nQWsdNvObbf3qfYSuKE51BI3K4IXFn?=
 =?us-ascii?Q?NUU5Z84ZWmIf2mJaH1FNoo0NM39cEwkIj5wSIYa8LlUGQPkR5kgE7FquqZ49?=
 =?us-ascii?Q?yDg8isJEJ5V8EMQDBP3D8VAnZAZKeteVDYS7trSzS3e4Kfckq3GBVe30zff6?=
 =?us-ascii?Q?ZEOh0ghzmO4JpgKmUe2636WQUoblVQcyJLXJPo/1/XaE2AWVukjFvWJPv6MK?=
 =?us-ascii?Q?32YpzR8+hkW/fG5C3c/7l4BXc+ndKdbwgsai7ttyRbczbOwfytt3tcObySv0?=
 =?us-ascii?Q?eRY91xCBG1PDLPURwDIVAr6+GJmOJ3oUCA1BltaES2GfU2xp6SnjRgruUPEG?=
 =?us-ascii?Q?4dmiMz+jyMZjEXIvmLtcRnGi8L1bP5uuCSbQraQwjdgJ2t8i5yZ3GtXn7v7W?=
 =?us-ascii?Q?90IeYF78kvFYOJxzkHOIh7uDpa8dEo2oCRmm+Et/8gwjA/0aC0d90hxX20W3?=
 =?us-ascii?Q?uvR+DqVRExkKqxEt4dX0+D4+65TEAqPUPHs+Yas9wcF6OfXxecLSWXWQI7Zs?=
 =?us-ascii?Q?B//65438VWYyoqxDdUNsuOELGLupdh7RkWzuip4UmRZ/zAXD8gsPG0dsNx8O?=
 =?us-ascii?Q?+zoQZmkExjNcRhCcHqM68r3A7MhiBBCXifdjioBWH6n66W3UuYgZRcYyUjAn?=
 =?us-ascii?Q?rIipF+PH8Fk+IsyUKEudgnY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bd029a-9173-46ad-b38f-08dbc6c9fc69
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 00:11:43.2785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMvbDHf59c8VhSNpnsLaf/vhlhnfzXNctcI0c6qG71BssAIMB/LGxA7/j8s+sCOGq7Nfn20yQc6sIMrGy50FXPkRftlyRynNVbQw0f2GxcFIY7x0o0/aMCWCijXj0KYy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7405
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sudeep Holla <sudeep.holla@arm.com> writes:

> Move all of the ARM-specific initialization into one function namely
> acpi_arm_init(), so it is not necessary to modify/update bus.c every
> time a new piece of it is added.
>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> Link: https://lore.kernel.org/r/CAJZ5v0iBZRZmV_oU+VurqxnVMbFN_ttqrL=cLh0sUH+=u0PYsw@mail.gmail.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/arm64/Makefile |  2 +-
>  drivers/acpi/arm64/agdi.c   |  2 +-
>  drivers/acpi/arm64/apmt.c   |  2 +-
>  drivers/acpi/arm64/init.c   | 13 +++++++++++++
>  drivers/acpi/arm64/init.h   |  6 ++++++
>  drivers/acpi/arm64/iort.c   |  1 +
>  drivers/acpi/bus.c          |  7 +------
>  include/linux/acpi.h        |  6 ++++++
>  include/linux/acpi_agdi.h   | 13 -------------
>  include/linux/acpi_apmt.h   | 19 -------------------
>  include/linux/acpi_iort.h   |  2 --
>  11 files changed, 30 insertions(+), 43 deletions(-)
>  create mode 100644 drivers/acpi/arm64/init.c
>  create mode 100644 drivers/acpi/arm64/init.h
>  delete mode 100644 include/linux/acpi_agdi.h
>  delete mode 100644 include/linux/acpi_apmt.h
>
> v1[1]->v2:
> 	- Used IS_ENABLED and made the init functions' declarations
> 	  unconditional
> 	- Added review tags
>
> [1] https://lore.kernel.org/all/20230605103550.2427459-1-sudeep.holla@arm.com
>
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index e21a9e84e394..f81fe24894b2 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -3,4 +3,4 @@ obj-$(CONFIG_ACPI_AGDI) 	+= agdi.o
>  obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>  obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>  obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
> -obj-y				+= dma.o
> +obj-y				+= dma.o init.o
> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> index f605302395c3..8b3c7d42b41b 100644
> --- a/drivers/acpi/arm64/agdi.c
> +++ b/drivers/acpi/arm64/agdi.c
> @@ -9,11 +9,11 @@
>  #define pr_fmt(fmt) "ACPI: AGDI: " fmt
>
>  #include <linux/acpi.h>
> -#include <linux/acpi_agdi.h>
>  #include <linux/arm_sdei.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
> +#include "init.h"
>
>  struct agdi_data {
>  	int sdei_event;
> diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
> index 8cab69fa5d59..e5c3bc99fc79 100644
> --- a/drivers/acpi/arm64/apmt.c
> +++ b/drivers/acpi/arm64/apmt.c
> @@ -10,10 +10,10 @@
>  #define pr_fmt(fmt)	"ACPI: APMT: " fmt
>
>  #include <linux/acpi.h>
> -#include <linux/acpi_apmt.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
> +#include "init.h"
>
>  #define DEV_NAME "arm-cs-arch-pmu"
>
> diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
> new file mode 100644
> index 000000000000..d3ce53dda122
> --- /dev/null
> +++ b/drivers/acpi/arm64/init.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/acpi.h>
> +#include "init.h"
> +
> +void __init acpi_arm_init(void)
> +{
> +	if (IS_ENABLED(CONFIG_ACPI_AGDI))
> +		acpi_agdi_init();
> +	if (IS_ENABLED(CONFIG_ACPI_APMT))
> +		acpi_apmt_init();
> +	if (IS_ENABLED(CONFIG_ACPI_IORT))
> +		acpi_iort_init();
> +}
> diff --git a/drivers/acpi/arm64/init.h b/drivers/acpi/arm64/init.h
> new file mode 100644
> index 000000000000..a1715a2a34e9
> --- /dev/null
> +++ b/drivers/acpi/arm64/init.h
> @@ -0,0 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#include <linux/init.h>
> +
> +void __init acpi_agdi_init(void);
> +void __init acpi_apmt_init(void);
> +void __init acpi_iort_init(void);
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 38fb84974f35..3631230a61c8 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -19,6 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/dma-map-ops.h>
> +#include "init.h"
>
>  #define IORT_TYPE_MASK(type)	(1 << (type))
>  #define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index d161ff707de4..7a1eaf8c7bde 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -26,9 +26,6 @@
>  #include <asm/mpspec.h>
>  #include <linux/dmi.h>
>  #endif
> -#include <linux/acpi_agdi.h>
> -#include <linux/acpi_apmt.h>
> -#include <linux/acpi_iort.h>
>  #include <linux/acpi_viot.h>
>  #include <linux/pci.h>
>  #include <acpi/apei.h>
> @@ -1408,7 +1405,7 @@ static int __init acpi_init(void)
>  	acpi_init_ffh();
>
>  	pci_mmcfg_late_init();
> -	acpi_iort_init();
> +	acpi_arm_init();
>  	acpi_viot_early_init();
>  	acpi_hest_init();
>  	acpi_ghes_init();
> @@ -1420,8 +1417,6 @@ static int __init acpi_init(void)
>  	acpi_debugger_init();
>  	acpi_setup_sb_notify_handler();
>  	acpi_viot_init();
> -	acpi_agdi_init();
> -	acpi_apmt_init();

Hi Sudeep, this moves acpi_agdi_init() before acpi_ghes_init().
sdei initialization currently happens from ghes_init, so agdi devices
using SDEI can no longer probe:

| [    0.515864] sdei: Failed to create event 1073741825: -5
| [    0.515866] agdi agdi.0: Failed to register for SDEI event 1073741825
| [    0.515867] agdi: probe of agdi.0 failed with error -5
| ...
| [    0.516022] sdei: SDEIv1.0 (0x0) detected in firmware.

