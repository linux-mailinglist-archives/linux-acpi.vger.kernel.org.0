Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78333694F61
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 19:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBMSba (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 13:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBMSb3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 13:31:29 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC914EC;
        Mon, 13 Feb 2023 10:31:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3dviqzBQT3GisVmzpbo99fL/7PWACW/M2G662ZsJocQM1S2qJGFNQ7sRGScGp/tx9TJClrenSgzl7ZrZKMRg4t/feJaMtd+qZmor5MxMErGhOQweLkb3UDzcsjhgIYIDRBmneu+kqXf1aAOTep1ScpjL+Qii4B2HwAoGPCzwWbk3UHtOo8JaRwQE8T6pBxqYBkK7JDPlBG7935XXPi8f4H4zT4IzGV2DXa5mmaFkBST7z3MYvF7h6uWUCGjrBar8EHt8YkybY3OD+CHWwwCW9kRCwIMM+kHR+RmOQxC9pwBwoYok/4sF7BUTicIbIh8PLCBhHdmCflWOGJepuILPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQMQb8bFcXsRczBM6tN89XkK5QXq2Ci0dG49sRceyTM=;
 b=XnDJ/7Ltp82l4cZYk73JlUaLxv3rLUqXlE6TNYP+W5KS3B/5br0xp+6Q2pqs1QdFHUnRkAoqvkYSEF7RHG2MavaGG+gJpOPEBGSybqB3Q/TX93BupjEY5rPQrk7I+qwqVvZoMNswWDcm0TUVIOFHKs/IHCXYxvXClCqNBdzgtpmGVAzF7otO8j8Fwvfp6JGP+0rMPqV72A6KdVmfKuTbiSLkb9ZezhJ4LBsCo7KPjbvLsSX3zMsSlRnnNivwiw93yx4T1H3cAhMC+sH3jfu4dkL8dv5yAcjOQPU0Kk45a+8VMYmwJG0e1A5judIQS3OfNnw8FlwFSpzvFsDSHf0Y4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQMQb8bFcXsRczBM6tN89XkK5QXq2Ci0dG49sRceyTM=;
 b=dkKmK/pQ+LYTWqMrrCE6gHw4eTHzCs8YBNJU+rPD6R+MddkIF7xulRmFi9n8aV2s1UzhuPSTC9AeIjD8GYzzksZGfGTJz/hEUpgtqq7PqqUkjbVOSX1SeDccriymPY8jC5WMdmQqV+DlS4umI3SFhC5d7PX8cPBU5nDvLjspJKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by MW4PR17MB5531.namprd17.prod.outlook.com (2603:10b6:303:126::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 18:31:23 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 18:31:23 +0000
Date:   Mon, 13 Feb 2023 13:31:17 -0500
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
Message-ID: <Y+qB9T/PCZ6TpYlK@memverge.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
 <Y+p/2S4rnrOOyZ8w@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+p/2S4rnrOOyZ8w@memverge.com>
X-ClientProxiedBy: BY3PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:a03:255::29) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|MW4PR17MB5531:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ff5507-851e-45e4-ebdc-08db0df08265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eD/S+QLbRCQucKAB1yjyS8hK+TTTz4A/+A8k+bNGkPW8CC/oiYfk4XcJSKRfRrfiEMtnwZT345/9Bz0OxiPzrwlBMvWqgq3XJpiDh2dO4BQ+Rkh0WucvqAIsEfQiv8K1jfgp/z99hgzPz3Kwm+fnKtXUz512Bse3AXh+/ckzSMUIjx8o12QthOebXp8XJfl4xZdnskKx2kkzshwTsjF0xLM4aWqfz652M/gTGk4lgYALXx7U12YXbQc4Lndk6UQNC993vmXALgmaLuVl8TqsS/CXec9UdsYboMMNdfLfqY67HZ5V9tdeC5Vr2/jxL+s8YIzytuA9g6t0pjbG6MVDCBOyZlivrcbF/sQdgGb1KNfuZ/hin3bSovvzlTE/j0Z+NJNBzFkaJMvI3D9GLl4qONpwPs0VZnW5r6NtS/elR5ImCf/o/Q5tGCHt3rzC2OzlIxxQpYECnEO8WKndQRJybLnrmvvQNO/5hAkASU8XOW5I7C1CKpNRt/26wM7tF/RGUA/shK8tC9huRDclWy4ll58effAoNcPXBUsJs2IM8d/cvgGVdfqQRwrGXmaKBzUe7QCF+g40vym90hxa8FRongsrX3k/eINr/YcBnUOMnl7nYuT5Oj3/blkULHB0ZuGiMUNgiNLjiPrRSz1ci8W6xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39840400004)(346002)(136003)(396003)(376002)(366004)(451199018)(6666004)(8936002)(8676002)(66476007)(4326008)(6916009)(66946007)(54906003)(36756003)(66556008)(316002)(41300700001)(6486002)(478600001)(26005)(186003)(2906002)(6512007)(38100700002)(44832011)(86362001)(4744005)(6506007)(2616005)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T4snBUbc+mX6W3Z12yTjvIlKGkOwZ3M+lrlTcQjyTj8noSPexKCEDmj8DcI/?=
 =?us-ascii?Q?+ZnigNMgXNHct2ZcDknp8gb71pksQYKWe/m+ERzSDVThNM43r+D9V5voje3C?=
 =?us-ascii?Q?aqLjZsq3jObL2Zxe57mGF1qvqMfhQQn6ge4LJLbo4IYf7dKn23QDGGp4DwzL?=
 =?us-ascii?Q?3eytdDL+Q+6WtGC4cpJwDMRSlXVJG6p575tjrxfIdbFw9C9C7vXU6yHnIqw7?=
 =?us-ascii?Q?oGCW7lyxVYCQ+GcLzE524o3q6wWW/ZtV6XilGIbOPKaRxUQJHNXYfjpOAV17?=
 =?us-ascii?Q?NqtTrNObuddKY5AdOyDLzOCOkFfBDtuOi5XMlgZ4tYz7doYuM5G0nMHS7c9+?=
 =?us-ascii?Q?bXpJVhYqvTZjah3h5tZxO16At4w2hBHA5ty5nNId143hLA5S1BAmsczYS2y6?=
 =?us-ascii?Q?0VBI4XSSzaK7hS3sL4J+KhaH5vmW3I2R/V8g9z6fUPZMqOvHJhHpCJHn0lDl?=
 =?us-ascii?Q?26MzcsXR76TzEZ1nUQIv+BnxO868EE6E1bfXrMSr0VixSMUdtHtOnRFlpT6N?=
 =?us-ascii?Q?HwOHDLgk6ugSBtZ42wNs6WmHn3gf1sTmNEGYqZSIn0w8dhx1ydtT8LTW+5lj?=
 =?us-ascii?Q?Sz8IGihZfGMEngkocy5SYD4MkpLuZVs36SGkd2YTn5wZnW0JTf2fNk4XN5y7?=
 =?us-ascii?Q?feIWh9HU0fwEwKcsAVJcTYMF6bAAvkzf+pVucpHeSM5O1DNBLe5XwBUU7oEW?=
 =?us-ascii?Q?seBsT57K/9eXL0ilq56U6HBzc7Z8PkuLjgiraJtWdnvHEDI30d1zijuNEfgU?=
 =?us-ascii?Q?lgeGTvwgg6N2WwmTSm9fgvYdwl4M0h9+1Fdu91vZGSiy3fmLKul29sSIGMFp?=
 =?us-ascii?Q?YpFa+maFgsUz+bc67vWMSWtpTmJV6Qec4lmfR+omzsV/U+vQxZk+OE9Q8HOh?=
 =?us-ascii?Q?fxLnUQQib89gmlUIZR1Ua/4AtCBI6NKQ9tsSgqODwZcH4WjXij+cwm+abs91?=
 =?us-ascii?Q?KkjamBZx47rWVjqWhH17BOWmVZ8ZEqbESlinf1ZbHU6+nnSkOJDizfBuzAAR?=
 =?us-ascii?Q?8J0PxSTfxGFOW7U6Ri7CoOKvNY29E5pA1dciSHhSds3fuLW4FR4MD7uREy5S?=
 =?us-ascii?Q?yKpsi7FGkgxA/FLv9zHOk1t/VMBidWjbCqOYi95ov6D+VhtBXBHCeOuqXmYS?=
 =?us-ascii?Q?4FftDRc728SJRjxOTGYP28G2JqAqnhXyGVQHxSxzLNH3+HZlPH4a/cD/ghln?=
 =?us-ascii?Q?Ytv6x4uaz+VR3chNpOMz0PugKaR/NXW5nOddkFxg3lBKEOPRfVaguV3nNl9I?=
 =?us-ascii?Q?hjnLd61jFnwoEc3pwFXhI5pomU8RgixHGh2W7Cqs9nHue7+/MosnkvC2bnxq?=
 =?us-ascii?Q?EWkcUayNU6vS/CB5GHGbyZqG/MBf/SUYNAz/AU8j7P6Rn3nzMEK6hDbUhBvm?=
 =?us-ascii?Q?Z/TcBKZvux+d35qJaieGHartfqPVYj7LvmJx8GFrOYy6bS+AABuS4pg/DSFs?=
 =?us-ascii?Q?uV3cWIhqLXxBbuW7k8FueR8GzjXQGvJ4VLF3T3CNI/OYYYiVHTDHSwyEu+pP?=
 =?us-ascii?Q?j+4OJKss0QTtMAh6rs0D+7LgHDC+4fBNJ0+1CtSUGWPRvDGw0A3SUefnkjo4?=
 =?us-ascii?Q?S4TjSsIsF8eEk7BgmMOpLGvr3h7ae0F7N98r/ssM4Flz8icOnKSHBy2BpFn+?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ff5507-851e-45e4-ebdc-08db0df08265
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 18:31:23.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oq9IKhYIX/ZEqA9XzEyMlG0lFycBjyYLL2D39SJ1sAGFOUcPlrfvQ+fd+3HFLw6/uAwoI0VF/LpzGZZmJYNALXrvsWIJSsrlZGaoH1hPl/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB5531
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 13, 2023 at 01:22:17PM -0500, Gregory Price wrote:
> On Fri, Feb 10, 2023 at 01:05:21AM -0800, Dan Williams wrote:
> > Changes since v1: [1]
> > [... snip ...]
> [... snip ...]
> Really i see these decoders and device mappings setup:
> port1 -> mem2
> port2 -> mem1
> port3 -> mem0

small correction:
port1 -> mem1
port3 -> mem0
port2 -> mem2

> 
> Therefore I should expect
> decoder0.0 -> mem2
> decoder0.1 -> mem1
> decoder0.2 -> mem0
> 

this end up mapping this way, which is still further jumbled.

Something feels like there's an off-by-one
