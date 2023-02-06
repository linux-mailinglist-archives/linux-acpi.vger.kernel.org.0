Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4BD68C6D1
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 20:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjBFT3F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 14:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBFT3D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 14:29:03 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DF310421;
        Mon,  6 Feb 2023 11:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675711739; x=1707247739;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kuUsuF+moR/PevNjEsVGxK/00/6ANaesrMKSCET1eCI=;
  b=KH1nZnaNMcJNSHdA4TlXOeKzuMYVCxeaRHpnsOmfBgqmPsMU3im9fBvQ
   VeEzmtvTctj6r0ksPuu/TWTwznkLdOea+d144CLePFNB+x6l2q4SSRGxu
   yW3uGJCASbHbMXaPW98IbacMdyaX285HbG492PfjnFz1Bo27p1LP+zX8T
   ZBvQ44/zdZfs03bgmEUkZ69tRinAWQSTFf5sSQUhH9Tm8CI8gb8V96cU5
   bEHHOpJLloq5J8S9jCdX/R80oVqQieOugYUBkVpQMVaEBTu+5kg4AsqmZ
   Eneog6SF4cFazI2xwRnLZBHR1ap9be6we9I5U01neeBZzqzfsRATb4pN9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="356658746"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="356658746"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 11:28:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="659940317"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="659940317"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2023 11:28:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:28:58 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 11:28:58 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 11:28:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j25WCnCb1cfK8hYt6EKx3Xuzi7mWaMIaZatuDGJ1PBdeb9n0ruATOCY60c4PP8c2eW1WieAXWGf8rcvHH7MuQnNQNe6DLBmDZjc9HV8vvQRELx+wXuiKdNdwPX3g6UeYMTqJTGnFtZqNYq2ZpbqWW8QPsxu8b4ofbxSJeYKbSj0uRsWZSA48T9PsNEyapUZ2tRJDKERqUokX/nEGjVh0+diE/PSqz3kpNPgXALkDjnk+UsUHjJZUhyvx6qevzO7LQoYvf2q3NDKVG3dJWw2JcP6MrlrS5UOM2bslnLII4MpVNuhWz6xPYPGQtYNhQf8lrM7oDis9f+MiGCQ1+zu8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF3Um2b0kg4fwgN00S0yuHPGUV75T+aWUr/Whp8bRm0=;
 b=H7PxrlXH5CDfU6nSLwEKb4Wys+vAZhmwVvwMDevq48Xnek/BnuMkCcrY+phWVoY47keq/TU0KWLYArKQXDq2mGUGKwqYuwwOmwv82e7CwItah8m6THL9fPm67Qu1YSJGwDXvppblIwQe/Wel7oNlYhiEWAkC7dZd97qn4Lwd9Fn78ofrvppfAxNYCs+dhRjRV/5mf3s/OBrkbX5RY7NUpnjIYWwKYFJ60PSKxh/+FsKoGNQItOi/7KJahFIFX+H0ZqD5zJlRK0N3iSCgyy2FALTa5eEWx/v+IUm+FHEDbQS+lbO+dJ5st1m43gp3oiNcn5jjq+vdip3NnULJI1L34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4836.namprd11.prod.outlook.com (2603:10b6:303:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 19:28:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 19:28:55 +0000
Date:   Mon, 6 Feb 2023 11:28:52 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Kees Cook <keescook@chromium.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 08/18] kernel/range: Uplevel the cxl subsystem's
 range_contains() helper
Message-ID: <63e154f45fab2_fd49e29443@iweiny-mobl.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564539327.847146.788601375229324484.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167564539327.847146.788601375229324484.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR05CA0193.namprd05.prod.outlook.com
 (2603:10b6:a03:330::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4836:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cab66f0-fdcd-4b28-10b9-08db087862e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +sK+amGvF0yZokrErTZSNiRwvGmZ1GX4zcXZ8rRFOsO2q9Y+PtDUVLJGZwV5nDo+RM/JQ8vxr+cZjC3SK60h9fO6d35A34ovn1oSn9v6/Opwu6qP6lP3KkGuzHvEm8VFsZqZBjTATqoVl2BbkGxFj3rjsMyIdUhR3VbugV6/TYMzGu2yFkVeU44KxrvHTG8mhN7HxZU9VFwFeZtaeNtDSnaiPDa4haFH/djTjGixY9WzO7QrLy0fHU0FKfYjAyZLOsq2ST6S79xDHd5vFP7I+/KtxdehnH0/Y4KuvgXw6JwGlB/fi48SSrgzRcoayunPbArKgFvETJn+C9bCKzfGghukZCJeAB/pfXkoOify/hw93sIePJGnB96HicGvRRl9cYye7hNmJFXqK+Gn0LYN5ZMDtGITOfkyY2iaQxB5eg7QXgftBlMfvxiAEic4INOwmf5qWBqTQsWeY7m6quKWQx/+jMoXOIsNaPSFEwnd62iQkAQFRw2QfAhfEmf5wS7Uk5nbXE8nRHlQznOuuAhvphlapmhBiYJo5QHjPoH9bRXnqce7VTcmFxwR3+QMEW++j4kVSbff876/My27FZyVmZYk+EBW2QrPXmNSyivGIxehm796VP+5Z0YaERaJaxY90cqNo8TlMp7hd21h4IkM2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199018)(44832011)(2906002)(6666004)(4744005)(5660300002)(38100700002)(6506007)(478600001)(82960400001)(26005)(8936002)(6486002)(186003)(6512007)(41300700001)(9686003)(4326008)(316002)(8676002)(66476007)(86362001)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8DkYcq9D5CuPcDZ0yc8dSZ110k0OenQiYUeqPmLTxh4Hcu1R9uwE/LQWHJ/w?=
 =?us-ascii?Q?wX6xIadvFBYeWJiJuHZUw0ZHz3TrYV/rK7fuNmIyd13NTzQhc1bPutlXHEO/?=
 =?us-ascii?Q?q//UiTrGFyLx9VBueTBfvkmu28Md3Go3E7Pg8cwC/aZ1sw62PmGv3EKVr2jQ?=
 =?us-ascii?Q?TZDOglW3JtJw3R8DPTzvzMDfeOk5yo6kx9ZKrKfpSekMAYRL4vEtxmZkngRo?=
 =?us-ascii?Q?aGnyOldulkJiVpo0wWi69uwyvyGUDDIkYFHDs08leAIPKKMlw71Nbh5oAWRl?=
 =?us-ascii?Q?S33QQwTDOJjTmr5KTTBoBIoJiLpl9umjg2DD0CuALjN86U2Xqc9xXyQ0cpHT?=
 =?us-ascii?Q?X2DCv48EyjPP3ZYZOonucR5mvfBYG1h/a5PRBYjhCNeezpfeakTiRZB/QU/U?=
 =?us-ascii?Q?V/WpBCtesmrRV6bGsKHUmCCC/ir6vGM/ItKktCOm8jPuuCC1TcqO0YM407An?=
 =?us-ascii?Q?jGcjbubPDfvmEzFFCLos4BE3cJX5K9DSWtA++fI5gGumlpA2U19vBmq0FfV1?=
 =?us-ascii?Q?vANWGWDp2u3gg2yQn8OhhVAH4WNFIHMxvgklgwzpgSVyOE6QVA02ml6VcDWx?=
 =?us-ascii?Q?rgI3ECHrPMQmNblhGxSyAeWM7av3Y2P6qnB5uv8W1LhltSgCuJMdtqSA1qG2?=
 =?us-ascii?Q?rBt2Twxocv3Xb5J/hapz8TwF92+JWjV9go2+j3oGlIrZ1WIAzoTpR8EcZOsW?=
 =?us-ascii?Q?lPoG6M/jQ6Gi6oZuWJEdsZncJjqvnADUBkMcAwP7ZwutKZpg+6kwHbFRCUNO?=
 =?us-ascii?Q?sY8CNGMWjl3v9S2N3CE83jjI0Fq6SIqXosxChtPSTtALUUXVYjddMpbRighu?=
 =?us-ascii?Q?bpTTj3nAIxhN8ZGe974NLPF8gkEJbcoh+TpVDtjNvR0wm9dlFgEdJmFUJZN9?=
 =?us-ascii?Q?4I+tD2bSEsb0H2W/XZlFhHM+R8tiPXGkxKG0QDY9/mMkKpnUgBejUDzTDFJd?=
 =?us-ascii?Q?7F7S7wwTm7JvC0EJGUfho7o9rAhAQMg15XyMM0bsxaSd9KSiMrZ3p3hj9JzT?=
 =?us-ascii?Q?Eia2WAZui+L+yD+RncuKam6fZtnfYIECrqBjviC8Lct9VRZo8R8dONm8NTrK?=
 =?us-ascii?Q?H9amN8j2i26VSRVtxPTyX0KnFNSLF8oYuXeTbAPzUPqmY49oB3LKJ/TiCF9j?=
 =?us-ascii?Q?FLQNornOBtgO49LIGIXKDVnb3z5eHpL2Z31KxkxpUhtBr+Xb2/XPV8WYxNYp?=
 =?us-ascii?Q?/p4ZJIY2g90caJkp0cpfERvtXesoqGs0ZdIQIhasy8ZLU8OwTYUohvzARJeh?=
 =?us-ascii?Q?2hQUdr7iEDQrA2OCDE4NeyLPVgGS9UawjQdywh/6afrOr+D2E/iLEgvfxawR?=
 =?us-ascii?Q?h5psFtwOT8QpuQxVG6vWnWfBmaiEF0tHFzKdwZdNReyihryfovihGOqyFodI?=
 =?us-ascii?Q?44B5PPgELpkLW0SVx3iRWqfuNamvNijwwVIDMuKQQFi6TPHNKQCwWk65qrLu?=
 =?us-ascii?Q?nsUHyRKwPk7iHaOcd6kx3dtql5DDo0C8OFYk2C6Oz/B7Y1C3Z4w9Iu/RI/Xa?=
 =?us-ascii?Q?EfL+3N9iwXKhaniT6LdfNkUQRuW3p/yTM2609bzEUWRoZHY8IJ6Qe11qJSS4?=
 =?us-ascii?Q?4fOzROtkclDNMJolFL8QaXeCRvCBjfimnYYFYMlw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cab66f0-fdcd-4b28-10b9-08db087862e2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:28:55.3793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6QJ8MBTCUfOeWov+MmzhhyG7RgmoHuLK5yJ8BOEiPLyZIBezCZS0bE+vaWEGxFN0cRdLVZzKh7SJZcRRf4lXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4836
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams wrote:
> In support of the CXL subsystem's use of 'struct range' to track decode
> address ranges, add a common range_contains() implementation with
> identical semantics as resource_contains();
> 
> The existing 'range_contains()' in lib/stackinit_kunit.c is namespaced
> with a 'stackinit_' prefix.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
