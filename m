Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBE568C914
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 23:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBFWCL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 17:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBFWCJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 17:02:09 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09A510A8C;
        Mon,  6 Feb 2023 14:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675720928; x=1707256928;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cFdY2OIVjVy0OPgr8VAk4Lr1ZfW1FYQryRW1Vhw4w04=;
  b=Hrda+lXISQsvdTIUCBCGv+N3M+PD7oeIgXzqWFpIrtqreOC6f7tXO6oe
   7dQzp97m3pymYkf8wCZqRh2JAKHs9umCU0oZKaksYTZpBkU7Ht6dfLFCk
   /L+INShsl8b98QJ2UN0utSaDndTj/S4tvlvXkML5d+jd6dWZir5WuZAzg
   hFPbdTdeWKdkTn+cz1v0+ORBNRD08DJzCCqI+PCr15dRNLQI51RCq1anf
   9zufGt6pkSFMdogJWfv708GGWmTDu3LGOj50nNl4KIGUTjvQSsAKmOaaT
   KPwakKxXX4rlDG1MzG20COcy1CSe9OYxvN0/oDgluVaEbU3hLxNDpC1Fe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="331461166"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="331461166"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 14:02:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="644206736"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="644206736"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2023 14:02:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 14:02:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 14:02:05 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 14:02:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCVSneP8gbYjYYvaY6nxfGoilFtLtgYDI5bklCevTbNUe1sr8IRe058sOZhXxPFnB8INSN6rXvbEJ3YJxjC9gxkLT5VJlhZbkL+Y97VI3cOq0UAfqgGoRVZNQ+ymMYYJCrSa/dsRmsO4XckJMY5xYV0bOv8XhTM2FZfA2vbwDCIzPWWVnQRERkLmLYD09qDIXKJbdqN8+sbslNw/43SgxlDzssqU5GfuJjNdimXEGE4JPtxkOewCy5REQ+azgXDt0EHdm0XuIDVvfxlrbhlesp/bSbWrLEZroiTiuNZgH5WaflC6k9grMVQhWlQP5UI2pu1MWeHsfCnjTCKFSbXJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5MpRdVxOzWjlv0aMUpmwMG9hu+lvuvq0NYp/LLSXTg=;
 b=ho20jK37h24gGgHiv727GG+tRv0mlKHajIHXBqFrqFdf+K/Ju7VK2Pzf4qWC7/l8nEZrE4uQw/OC6L0JuOQqQ8MFlhwJfc8ofI8TwJjti4+ZAWeCgUNO00ImTM4m4xauo3le6v3vWdtqg4QDv4Isc2MJElgSFVR18+u8MMr6iDz0431BwiiJsINiBr18FnfhM9kyXs5ACNBKRgQ0dnd3vZ65KLQJx9UkkqXXqbyacQDg93pZa1VMdTJXOdjBJiDIzNwRqpYR/DjvoGRXafhJd/B6x9xyle0MCsRbCSdc5yqwBSAizgqAiqQEWYp4qatem/4wIk3Z+82Wd3d46h6lcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5980.namprd11.prod.outlook.com (2603:10b6:208:387::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 22:02:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 22:02:02 +0000
Date:   Mon, 6 Feb 2023 14:01:57 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
        <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 08/18] kernel/range: Uplevel the cxl subsystem's
 range_contains() helper
Message-ID: <63e178d59841_e3dae29465@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564539327.847146.788601375229324484.stgit@dwillia2-xfh.jf.intel.com>
 <Y+EynoTcMzofUbi1@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+EynoTcMzofUbi1@memverge.com>
X-ClientProxiedBy: BYAPR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:a03:100::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5d7204-af3d-4062-a027-08db088dc6f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SsHr8105QKqQMq8txvw4oIJtpBTArZT22lmzKzRAna9hQesJmigQr4jOVEpqhtWfHmwWvJTotrAV7j/1EWs9H4MdCHlXc6F2TdJ/AR4KmVeQjyy8Re0FtgAUlGcxsT78NorbxNaInOlemovn1fCfClsCmjHJt5BpUa02SXXQsfUoOnpl/6gQGBzLKY0f9G5MGMynQDtg8mykHxL9LU7JsVYLHiI/j0ogJNPbSa2aViiQpPEwPMcyr8KeAV1l4O7FfXRzxRdY+KauQ1yeJk9vpoETCl4YFYZG17rtXrz0l9Xf0AKDQm6sVcxOgs6aygWoKktilrQU5mK2EBS4wSewbpD2f0w+yIhMUGyhSIaAej6qbmhnT//urUZQbgcKsOKSWde2+erB5wNea1eXsyVoYH5be3VIbcrwJSsbtBa69F7pWgyhj7zAJksHruVIjtUlWtXYe3QmXLmZYunwKUIda09CPN61+dvsKIS84lvXKD33HqmsLclIIOLluSYEbbcMpAbWXpdy2u3fvSJoKeY+7eWUVG6nA0ZjBC8wnopzBplteLWq1Q+Tnh/GNG5uzWcGXuLqYBZTE2xRAx4G1ocB1+vUVJv8ziioRonpPLZwM7VyodmLnDb6ZeTTHHXnOIiSIoEtUpOmNeZsO1ZLyUAEew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199018)(6512007)(186003)(6666004)(6506007)(26005)(9686003)(478600001)(82960400001)(38100700002)(316002)(110136005)(41300700001)(8936002)(2906002)(5660300002)(66556008)(66946007)(83380400001)(66476007)(6486002)(4326008)(8676002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MsEVSa3s2mjcpyFt4kSvtLe1Qg5E0vivkK3bjeezGZlV6UK2HywI5u9xksqn?=
 =?us-ascii?Q?kW1K4tP+5tOzpj41G+QYz8N5jw7ADkEoP92acUogQ6ts3VIQCwtTXodNH4cm?=
 =?us-ascii?Q?eMkB7udzFYI9U2KOCGf3B80HvTe9Gs/g13m10KlynL6YkTgvKB2l7S6C+9IT?=
 =?us-ascii?Q?tfHyPivCy2yZydHBzDXA6s9a2LupABEUZjDLc6+A8XDn9FO+bLwfRaCn5UqX?=
 =?us-ascii?Q?FKij+QItWgN/WgrDIuYfboBH1sjBWeMR0lcaHAa/fMWNYedCad37Ubwb/uq5?=
 =?us-ascii?Q?0i5GIZN4RqcJoyEpCrS8dB4wAimc6w8SThZ/m2ObzNaesMBd9Hat93i3UZvc?=
 =?us-ascii?Q?vKGacl46OyuLzHqnlxCwvAeFemwitZ9VztAeJnygfjXsynFmqXMwcj6PC7ho?=
 =?us-ascii?Q?uNOb3NgiUIyOn671GAIa71z76argbcvmet+COF65HtEfJCcIN/YkIxxUhWme?=
 =?us-ascii?Q?H8qOjq5AAgloGyn8X9OD6AmWRXQFnRbkd2yLEsPsA8OZP5/8+iMdZEdskacW?=
 =?us-ascii?Q?CH03oJdCv5fcA+8cckwePSngVhFQUCFA/71wgAy7Dbea6w+4icOWkV1Rt157?=
 =?us-ascii?Q?BgJVlOJELiwwrPeeuEgv+QKlEDmhzYkin198WOZGl9Urn/RNJjfkVrGJolfQ?=
 =?us-ascii?Q?YsLtaxuzC9ZcE2AHtZTefTF6/3kHxUSawH99wiNC1WQapLPA+W7aLraxo/yQ?=
 =?us-ascii?Q?EeZMXKRw7XQo2vsmab06Dv1f3WZofBkFJNfaj9oK0QBToTflMEHoT8ppd5Xj?=
 =?us-ascii?Q?+K7YHS7aM++JVDkH4Esh5L1AsrqQRQvy5pZi6x4vsFh755GkuIZwWuqTUXvf?=
 =?us-ascii?Q?xszm1t2S7D9Pdup1oH/H4wuvlIhi0MaWnUX6rZColY/qBDeoIfUexDV0HN+b?=
 =?us-ascii?Q?i7JdJsj0DPYU6OKM3z/TapAYt3RP7VdiX7MkhFrizQ2dAuoDrPwPNHqajPdK?=
 =?us-ascii?Q?WreGYtOtucD7fFy5g5KCa27P00qVWgixa63VOunVuq6kcOzfpgx88eiqANOF?=
 =?us-ascii?Q?G4Qmi61aCpOPKdiR+WFPyGdSDH/e9m3x6+gnSh0J8LWf/oiYbr+tfkEvEDdj?=
 =?us-ascii?Q?V0cSGzH4uXu5BJy+OalkC8xlY7FFxDBcSTWf7Y7rpGHjH1buMwl0jcHG1ws+?=
 =?us-ascii?Q?SnzGWhFClKM6sFv0yIB2CTq7SajyY7Ecqit9v5qX/K5CRxVvJxNd7wMU/JKO?=
 =?us-ascii?Q?2BLtm///LDy5aGeAk6ouc6lHaqYJvlKN+klcjdIxLwUXPU5JLUfWgkZbPYzs?=
 =?us-ascii?Q?oNoCJRBpt4sGHdarGsNOt4TGZkU3a8/e6cGfnF9lwo2KPVE+r9QRWqbJ/Z1Y?=
 =?us-ascii?Q?wekoa4WvXoFKA8mu2aFHkTEtpEhzS44PhS6FvBBJ7VB9WZRIL268Z/e/ZgBW?=
 =?us-ascii?Q?3uke3lI8GPlN6cQPU1x163gDGbvtrfx2gDe/9lKVJURfoztRlLrKsStg5pr6?=
 =?us-ascii?Q?4N82bBfJ5Zz4KiQkLfhUsLC2DQWrb79DJM4KJpC3oZ4W73jOmqTTgYZN4IpJ?=
 =?us-ascii?Q?Z675djFAb/ehDbAcwrXl7gAgOHDEeDMcchJCJrP257AXTbDrVM/4kW6HcoLC?=
 =?us-ascii?Q?1GGjSPQNn61H0aBEgEgcKl9fyrWGxGzgDAbiJBYAye81K44hk1JP+4yJj5QE?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5d7204-af3d-4062-a027-08db088dc6f5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 22:02:02.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaFBe3raeS89Z1Q3V2I+h33DmRiQF2qpCeTA7K/NHbVH+PzZuaxmtC0do1/yekHoiBk+ZJ+s24PUSBW6+fujRCxgo2mbEBMAe/h1zbqf67E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5980
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Gregory Price wrote:
> On Sun, Feb 05, 2023 at 05:03:13PM -0800, Dan Williams wrote:
> > In support of the CXL subsystem's use of 'struct range' to track decode
> > address ranges, add a common range_contains() implementation with
> > identical semantics as resource_contains();
> > 
> > The existing 'range_contains()' in lib/stackinit_kunit.c is namespaced
> > with a 'stackinit_' prefix.
> > 
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/pci.c |    5 -----
> >  include/linux/range.h  |    5 +++++
> >  lib/stackinit_kunit.c  |    6 +++---
> >  3 files changed, 8 insertions(+), 8 deletions(-)
> > 
> 
> Only question is whether this should be upstreamed separate/ahead since
> it's only tacitly related to the commit line, and the stackinit naming
> seems overly-broad enough to cause issues.

It's easier for me if it gets an ack and goes through the CXL tree.
Otherwise I need to delay the patch that introduces range_contains() as
a global symbol.
