Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4069316B
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Feb 2023 15:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBKOFN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 11 Feb 2023 09:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBKOFM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Feb 2023 09:05:12 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4314525B9A;
        Sat, 11 Feb 2023 06:05:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCQS1KjracpvaP662wlIq6t+Sokd98E/fzh395sjRLxzGCJqk1Q/490itDq+XvOA/mr1/pLpFJ9DkqqxvCdyBdybgCuoyl3rRPYaSTRfWOFntnCFWRCDuqOJESo/R0YHlIUJdba/QJO2L8/JB9uFg4860VwjCVUsCLFAP0MGIUUsGqLbv5DTT+dgIthG6GG/NNhRCfhcPw6amiF4dWtKLgiJ8xHimIKrAjt4nmP6XbFhzXJ4iknWULPhKAGwWqF+B4leZPG+u+BWEIZaDTSzgovcsFDM/RAcLBxkzJVoa4PlWfreupYkQIP1z6M81tB8BhzLkjcpxbm/TEv6n7sVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBnLN7WJV8lgx3QXZ9qsCn2X+CaPJyeJf8lsAtsNspU=;
 b=CADc2+XcqVB+TuQ2Vy9Qalpl4eeGodNqu2r1TF46ZzafgAvxuMhuXut+0Q9PHTrWLt8/3spAewIj8tkLqXj9xIR+OvTxXvPU76nGxRTyXqp/X8bJv0frh6qWAcm4FI6oW7majFSbaWjHGnrIrKMixKb5LxIjHc44tUi0kjkwXCZwMvWoTfDl/nygisYKgNKbmP0q0nDYsuF6Xx+qzrSPcZaag/gsnairl6NA8qT552SP1XGekwpj5goL3AznFef+xBgjGq+cqDI5ZwKnOtyF8mPoF7Vwmu056IGeuZV3PH5Cn7FFEo7WDWR+UcRThYSvGL2YXUSRrptR8Lpq7GnTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBnLN7WJV8lgx3QXZ9qsCn2X+CaPJyeJf8lsAtsNspU=;
 b=GIyQ7z1eCDcJF2gI4GjWT1I10hHO4lf5Yn6y20XRcDrlBuPnhp8RGVLwfDgm8bhwNjPbhl3bgBx1CWsgdoWJvMADhQMCpCenMRN7eAPliH+1mksbFsdVzVVaYEZFrBl3Irh9DU5o9WXlh/w8/klD/AEPO1fekT9ugAgbrw75mYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by MW4PR17MB4859.namprd17.prod.outlook.com (2603:10b6:303:10c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sat, 11 Feb
 2023 14:05:02 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6086.022; Sat, 11 Feb 2023
 14:05:02 +0000
Date:   Sat, 11 Feb 2023 09:04:57 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Fan Ni <fan.ni@samsung.com>,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 00/20] CXL RAM and the 'Soft Reserved' => 'System RAM'
 default
Message-ID: <Y+egiS92/AGC+05g@memverge.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
 <63e6849f4c1a5_36c729462@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e6849f4c1a5_36c729462@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MN2PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:208:23d::19) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|MW4PR17MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: 997b4d74-2019-4568-8d06-08db0c38f80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwPCu/o0mcYxaL/kviAI84cVaj5RTtRaYZ5vqwXWSeFNXuouE7xqm5HXV7lSB1qbMFm9YbjeY3LegvPOxYKeRhNrQUqyeK8K+ib9jeUh7ZivdRhPzLPERCFfhZwsNx0xicStK7Y0zs4EnaPb20Rg3F+8+pc+p2kE2o9bxBPRkwfe8VO/pI+sP5jj6vFFN8Qn0I4pa0zqX+LLw+O3sH0XNIN0c5Q0PiORMjG5qNd8td9P1Lsr5LQEUYBSifc3f4nYcdjmvxRuspcHdiYKOjiAEMkMozGDJ75CwTa4BohzWsDtnAJAQ728eNaiWqHALlNYpERhvDMnc3moAB1aKRDQLUxco12uw+iG1v9u5vWFYiUl/+dFv/aoQtTnswYMtWWPQ+Mu/opiAtz2i+j2XUB0EaXR4yIBn1sLDdv0P7zJ64qddMrjry94sujv9uMmSJ5r1NRt5BUAQm6sb5WmwZbHlLqJ2Dxfny7VQ3OZcD7ME0LLxIc5Bxec2nrQJgbTXahyhvGfTUnfKyIx6SaeqhgeXaW/EImPBHfwu5bYCOF3jXZAY5VNu63zx92hE+3f4voOHiQM6iz+nuoGpQuBnE0RPPkq9C9gg9s3j/Qs6lIvdXW9pcwQ8WZFoyVW56XACrOfv1oBVGAGSxG5T1Lr6THbdI3jV4Kiyt2VTSdV7WHO6jZ5XjuPS/QeLtB7TCz91Avkkng0SSPyR1oBdf+snPjfJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39840400004)(136003)(366004)(376002)(451199018)(66574015)(83380400001)(38100700002)(86362001)(2906002)(316002)(54906003)(7416002)(8936002)(66476007)(5660300002)(66946007)(66556008)(44832011)(4326008)(6916009)(8676002)(41300700001)(2616005)(6506007)(6512007)(26005)(186003)(478600001)(966005)(6486002)(36756003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2wUC3RN/y7j7lc2oQSou6CLYAeF3HbR3xvqrWq6B34BwYL+hfX2aZpN4OupU?=
 =?us-ascii?Q?/XSi9dDLF4PoWS0k0AFu/9/g4koFDw64w4XOez6qvWPMMpkjqn7gQBABZhIS?=
 =?us-ascii?Q?wRn8IvoquO50wZqssDpYyhvFVyH9pZQgbtyZkgYDCWV/rudVCXj+ButpI/ov?=
 =?us-ascii?Q?yszh5wTMCxRJBwK8DXE9hmLs/sTz0nlnQWWCdniDUOP82UtkF3l0Bbily/ck?=
 =?us-ascii?Q?DOO+lIWbpB5YQgAxn5ZE7Ypw5Y6p/KYxV9b7/7WHMgogL+yZEMUcp5CsbaVt?=
 =?us-ascii?Q?qv+TJZ9cpWtnHCGn9L72m2e+bxxql6DNuUIr3xiuhDrPEZqYowQm4P3luZyO?=
 =?us-ascii?Q?sGa6qWPoibWQ2ih7S+yacAiX7DAKgtHWSciY2+5msIe9RMVpInXU8Rvsj+iH?=
 =?us-ascii?Q?u6LCUourT8UK0T2M/zj+iSx7VuOOd52dVgQbYeBsEuyvVr5Id6+Ra2+leKAq?=
 =?us-ascii?Q?XptMOBJ0SZztvloz4rL6q8vkwDCO+bAsif/yrzNQSjfDt2yzwMJfqRP0TD1M?=
 =?us-ascii?Q?kmUoBjToQ/0MoqgkflUdHdWyW/r8ACFQJrXbYUE1gVBwSeK9BrfLIPGLCtlQ?=
 =?us-ascii?Q?wXDuV0YMjkTMExq6Q55bKbOCNM+xNZGRsHH4uDycqVel9HShbTGwuLRy3BeC?=
 =?us-ascii?Q?VUNYhgRG4R8AxtVThto0zs4ARflRpjH7YlrADdOAAsS5ZyPXc1DpsvM0oXZ3?=
 =?us-ascii?Q?Gi6KVnavdZ31Kq9JRBOh2V+veVyC4YhGgDx4veuWUN4GBP9FTUBMZTQCmb24?=
 =?us-ascii?Q?gJsWdJ3B0M3lh8MhsNnxKYP9sMw5KovMs8CWU+hcZ//jUYqYGhP/Vt3djcJI?=
 =?us-ascii?Q?J20+9jv08X1P7LyvFotQBoamVwFUMw80XCSlD7A2gzYXowVVRHQqDXr0EKrs?=
 =?us-ascii?Q?nzAcifxPtkRxJSsRMwqlqJ9nUJWCJ34RbfQJ8fuzBv4bIwUXEGObCujStWr+?=
 =?us-ascii?Q?IS7gvt2DSXTtf+hILDJ8UmpoflyCgmeo340bDYSozSdcy2HwytZB2JXo38Nm?=
 =?us-ascii?Q?3oGR0uFyx7w5AlHKJTnbJTiUFvcPzI4BwGuB/kMITYplUVPwZP2NB6/e63sM?=
 =?us-ascii?Q?VUFUzyHZXO3rArJ+mmd+41CnQXlKJNxDs+R1y/qOgUnNItEZmJBhfeqTLQqF?=
 =?us-ascii?Q?RARHxrIEhSILUF8rSKXdg9rP6SCp984qJU+z8icISAiKT/83S4b6mmIhUw5h?=
 =?us-ascii?Q?L1LOfOxpi+3A5hK8OGOzoHZulxj05VQZ/5SV/yi8oq0V2VdLA0PfY5kvX3Rj?=
 =?us-ascii?Q?GV5eNVCcyIrcA6zFxYkt9aTUVWANPWSHaXCm5pGubAvVPB7vBjUB8zgdg8ek?=
 =?us-ascii?Q?qmXYmR9JJwJ+9gxaNFUcvCxV5kFRx1mf1rxUBz4yPkWvTz5iOpE42uMiILmK?=
 =?us-ascii?Q?5SideBZMmZ0tuiDWBhhorBsRx+Ep18u1e11iw2saJQu5azZixTD3NrxeDGu0?=
 =?us-ascii?Q?CCSBxoxnNSb3k5RnKfpEAvLi98IKAj9FApe3SMyJtStoyIJYatj39TzVN6YC?=
 =?us-ascii?Q?8tGcFbC/jLUHRzuvuiTerq85juO8TFpe0EJTqQc90BvTJrvh+dW1Lv9U6Ax8?=
 =?us-ascii?Q?3r2E8zDEe4T7ht9G7ipz3L4IZ5eNZ93KUSlw0KXLL8E2Veukuehlz1x+g2td?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997b4d74-2019-4568-8d06-08db0c38f80e
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 14:05:02.5274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUL1kr+6+cg6RMz0KInHwhal6f7XqbZadeP86tNr8dqWPIKJ8HDk//8HvLkT9uqpdav3EfuaKCZ/q0vQB3MFeP4RfjkkYyZUgmBZIfyLA4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4859
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 10, 2023 at 09:53:35AM -0800, Dan Williams wrote:
> Dan Williams wrote:
> > Changes since v1: [1]
> > - Add a fix for memdev removal racing port removal (found by unit tests)
> > - Add a fix to unwind region target list updates on error in
> >   cxl_region_attach() (Jonathan)
> > - Move the passthrough decoder fix for submission for v6.2-final (Greg)
> > - Fix wrong initcall for cxl_core (Gregory and Davidlohr)
> > - Add an endpoint decoder state (CXL_DECODER_STATE_AUTO) to replace
> >   the flag CXL_DECODER_F_AUTO (Jonathan)
> > - Reflow cmp_decode_pos() to reduce levels of indentation (Jonathan)
> > - Fix a leaked reference count in cxl_add_to_region() (Jonathan)
> > - Make cxl_add_to_region() return an error (Jonathan)
> > - Fix several spurious whitespace changes (Jonathan)
> > - Cleanup some spurious changes from the tools/testing/cxl update
> >   (Jonathan)
> > - Test for == CXL_CONFIG_COMMIT rather than >= CXL_CONFIG_COMMIT
> >   (Jonathan)
> > - Add comment to clarify device_attach() return code expectation in
> >   cxl_add_to_region() (Jonathan)
> > - Add a patch to split cxl_port_probe() into switch and endpoint port
> >   probe calls (Jonathan)
> > - Collect reviewed-by and tested-by tags
> > 
> > [1]: http://lore.kernel.org/r/167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com
> > 
> > ---
> > Cover letter same as v1
> 
> Thanks for all the review so far! The outstanding backlog is still too
> high to definitively say this will make v6.3:
> 
> http://lore.kernel.org/r/167601992789.1924368.8083994227892600608.stgit@dwillia2-xfh.jf.intel.com
> http://lore.kernel.org/r/167601996980.1924368.390423634911157277.stgit@dwillia2-xfh.jf.intel.com
> http://lore.kernel.org/r/167601999378.1924368.15071142145866277623.stgit@dwillia2-xfh.jf.intel.com
> http://lore.kernel.org/r/167601999958.1924368.9366954455835735048.stgit@dwillia2-xfh.jf.intel.com
> http://lore.kernel.org/r/167602000547.1924368.11613151863880268868.stgit@dwillia2-xfh.jf.intel.com
> http://lore.kernel.org/r/167602001107.1924368.11562316181038595611.stgit@dwillia2-xfh.jf.intel.com
> http://lore.kernel.org/r/167602002771.1924368.5653558226424530127.stgit@dwillia2-xfh.jf.intel.com
> http://lore.kernel.org/r/167602003896.1924368.10335442077318970468.stgit@dwillia2-xfh.jf.intel.com
> 
> ...what I plan to do is provisionally include it in -next and then make
> a judgement call next Friday.
> 
> I am encouraged by Fan's test results:
> 
> http://lore.kernel.org/r/20230208173720.GA709329@bgt-140510-bm03
> 
> ...and am reminded that there are some non-trivial TODOs pent up behind
> region enumeration:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9ea4dcf49878

I have also been testing with generally positive results, I've just been
traveling so internet has been spotty.

I'll post a full breakdown of what i've been doing on monday, including
poking the new kernel boot parameter and such.

~Gregory
