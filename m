Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D3D719185
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 05:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjFAD5c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 May 2023 23:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjFAD5b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 May 2023 23:57:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25C0B2;
        Wed, 31 May 2023 20:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685591848; x=1717127848;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0rJc8Q2/QIpF8ZGaltNCv3kgOjsp4kKDscQve3rLc0A=;
  b=bE1C/bdW8xc3+3KpEo+SpLmtrhz6hG45IwIdvU+8vY7sip9k0r2vjxqA
   DnxxS2H7MkTJc5ZGvx3aOCUsZjT7npKGvaCOYhxAAsu5x459ReQuNEPpl
   J7dTKtoy1DxJSvV5tYTYM6/bTStxNZYPGU+2GW8KowKjAFWG+zOhJs3R3
   iUGTj+0O4IT/Fh96BpFd/GWDaPGwPVPtWDaOyOj88YXv5rJ/ATzrSDK0r
   QeBc9lFf0dIizvvCZ5U0k5lShBZzANQRlkilQff1sygeVCeDEHUCHciSP
   kkeKG03WccE/VlIrZOjlz4CcRUxzfMoa5OUPO186UZDVbbBvgBRvCX09T
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="340041478"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="340041478"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 20:57:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="684680024"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="684680024"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 31 May 2023 20:57:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 20:57:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 20:57:27 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 20:57:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aqzign/ykYQktOG0fISmvGMqffldd8UUi6VM/evJ5R6FOLSpaHcsGFHwXN/j6Hc5wP/4vZxqFziFgiEhLelWt49meG0lcyFBMlbIy5iJwoQ/bq8ULfdDaeNkU8OXq+qrA/yTNJqroYqReEY4alg9uBfuarHkLNe0ASDdG9lzJ05OMGGLlCkyaXIiUjKAtjOa16YKW8Y3HRBHwWSgfrTGxcTiuilmUndgrzJND8xizog2LU03UaSWwMwh7oi0ci7pZQjrf+nnw1ZB+odm6jumxor8xNuVK66mOstNofWLhPWVfX7dHEHSYinz/A74T6C+IYaxM2dBIAXUPdu/HXgj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ruq2SwPiBuFwYbNV37gJbHlosh3zkY5sP3NwclpwdXY=;
 b=YZILZpQIi7UooCsESLmGGSB+IfDit4NSS1SBLlVvH3KYpK9/gM5BiPPtG3l/em1l5tKLy1C1BaVmC3lxTBifBYyxbIAShc3hdcrMTEb9C1cd+u87WNqiJAEeuqlhtXebr+mjFbAonS8qiGXG9P/y1j9aPGzs4wKwsZuS6/BJJrn+WXTECV63XZBoCxmyBwRLhPUhB1r9gkGZXk5Hr8iNQbofWTviAexP2JJOkUgSFufZiUgHwjDF1PYkr8JlDXOfvDlPCmfJCUxNKUPxN951Y0EivonhhAy6Z6IcAd5YPlPfrtKr5YQyGkW6Wr5rBJxse+1EfOux3OF6eK55ansOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 03:57:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 03:57:25 +0000
Date:   Wed, 31 May 2023 20:57:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ben Cheatham <Benjamin.Cheatham@amd.com>, <rafael@kernel.org>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>
CC:     <yazen.ghannam@amd.com>, <benjamin.cheatham@amd.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2] ACPI, APEI, EINJ: Remove memory range validation for
 CXL error types
Message-ID: <647817212bcf1_e067a2945@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230403151849.43408-1-Benjamin.Cheatham@amd.com>
 <6477bcbf96b48_168e2943b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6477bcbf96b48_168e2943b@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 3209fec6-cfcd-4af5-3a4c-08db62544ec6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JR5RrHdhnx75pWYnZVbfqH6mcodtDucx3RT4HKPVfevDjOXXQzbftOg7sip0PFh8vcXQSAGKlxUaUiWv4DOML5xQKvTr9y4qAAN408G5GY3kv1losGaOmJWaYBQe7F4YSCHfnHUrviKTedL+Ic4GQYn5YEa/LzeunzN4IRA133EUwfkSclJ39M0Mm6dydDKlsetUGwL4bixsy6xHVMFdeZNbAGVKHFPfg4O0HwV+DVJrkslFG9Nd+H6muiwud93ytqiEIkpMCy00uW0wTD1X/75ALQ8YOPEya7GaU1H38iwLC0N5T7/LT+vsSB91O+fW4ZGcMSkSXIjPyVFYvHi13L5ntwwF4/T+M0inUgFZOlsxsyC/K+/T0Ukcx4cPgWBke5CSVIWnvTRX/Zvc2cTwZ0kBfYF2TzEuF0L5BYb3BDNTvv2wNBMkN+CL4ipnRCVE+412WGPeqaxZRkVlZh7JdKiR+5gRR38z5RLLH8+O7decXXjsIPgqb1c1l2Hrh6R0+ytRh+IbXe/qLtGH+lhnkFG3snQ5FUoyEzyMFecaDlFFVIJoETpJiatCoihycf1q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(8676002)(83380400001)(186003)(2906002)(6636002)(4326008)(66556008)(6486002)(66476007)(66946007)(316002)(6666004)(478600001)(6506007)(5660300002)(26005)(9686003)(6512007)(8936002)(41300700001)(110136005)(38100700002)(82960400001)(86362001)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CbW5Hzl/d2v3kE8CWH5nkBo2aoO6MJm41Ae/jmvQBOscdenc4c+GhAO39zYZ?=
 =?us-ascii?Q?c/ZnuMInt+X1A1gdZ9mMVeLEiDDMdJWj8LvNx41NNBn85tJmEj83zr5/kJXb?=
 =?us-ascii?Q?VrjU3Np6YTFiDJ+3v7ZVW4OUKpwiEAzHT8caVnQshEd9yOC6fO7gxgasmY0Z?=
 =?us-ascii?Q?6knm86Qxd+ej2pKGv83nRGTE24tci37JEIR0vlYg8G6vFGLWTNvMDtkT8ZGF?=
 =?us-ascii?Q?E66rkmemBF0laQg7ek4QGyWcXxa07cRv3cEhywiAlJd8w6F3GBBrlMfSgx19?=
 =?us-ascii?Q?fs9kVhSdL/3/+y8hHw1VZDf6/5AmktzYSmdsZlYBDgtzRA+8a7IbG97M7KSn?=
 =?us-ascii?Q?DQ6uMRkUS17y7+DCXL2qVQawd+lRhb66KbgPKh+GHjUJkmdbr6hH9BRSBV93?=
 =?us-ascii?Q?M1Er/OWIQ0PSq1ZTkhFaupMzU8yV8pWUO1w2TxOIy1jHFolZ+9FVPysFZlsv?=
 =?us-ascii?Q?78CqVoCMnJVqU+9gbDrvU277ldMCZy5F8kx9JzzScVTxjSLMOtjHHgKW7hbg?=
 =?us-ascii?Q?W0+QUru+cGW+pAbko2hIkLbfMci4y7Kv/No2yquwD9suAPL88N57VHiFj0SC?=
 =?us-ascii?Q?rxHklMYsRN6ctr1iM5WG8SVUKLRGrhIGJjJPg3nonNIt0TPMa14DryAZRiJt?=
 =?us-ascii?Q?SJjTPOnbbV0YAfWuvkiFTgu3hpKTzWuC2H5LJdBgIJqoQ8vzQSJ5IRpI+PXS?=
 =?us-ascii?Q?XFUDQByJewxxaq52nH7TLRY5DcD84456+PfhJnFOeiIwCddDLsL3amx7dMIg?=
 =?us-ascii?Q?76/yMmtVNxcLs9N4KSxe4mfHgh43PsPhSAPVHyG99pqI2/HsHiAqOnnrxDjG?=
 =?us-ascii?Q?WNbHZtp/FXR+STbTfdhvsCW3mHyHNBOzPAJnuvJigP3T5weL6RvQjDfaSmiF?=
 =?us-ascii?Q?iMFl8bPAlpmuEL9S9mezqRbVY+nnsYZO7tZ1Eak79rK/2E7DjKn7pm9pHlAG?=
 =?us-ascii?Q?7PuSPpWC6AVAPxtBlYgkqkuauy/7NnFHospb/GPpjF3AC8RphLUn6ilNo+1W?=
 =?us-ascii?Q?oU2/vR285e/VjhoEex7PDQ4fAMIO+5YaL7LPiJt4hyD5p7UPuSjNWiFGDhXp?=
 =?us-ascii?Q?Zj9XVsZgflIH0UoRgclKn78aaztKEp1CPTE3lyYUemjFfsBNZWh/akMbdYqb?=
 =?us-ascii?Q?noldxRF355cxhmv3E0l6O/caWjoO18xpAtFa7cvNmBMllPc8qo7z+UHKjRZG?=
 =?us-ascii?Q?9neKx/6/pMEZeRFGRj1WZYUUNJFRmMInqVdk7F9moCyhcSrgQcPody/MkTOS?=
 =?us-ascii?Q?86/erVUq8F4cJN9aJk1UsLCi1I2WXj4l/hCufGkcQX2hxZdtz9ZhLe97JKcv?=
 =?us-ascii?Q?NYNk13Q7pOR4OXpAucenapSyW9Qg3d+OoBpUDgsS6S9/MJT6CeHynacaZsIg?=
 =?us-ascii?Q?+r4daD1Iihq8/3Lc7VTK259PX7WsgelymcD5rlfm3VWyas8q7uGaH7jul2gd?=
 =?us-ascii?Q?3TqBjvLT7y4PA7mUHTKlBavdqPjM3ENSUI1N7yJmtbIDwV8ilsWnJcBZKy68?=
 =?us-ascii?Q?D4YYqMMxJJE6kJ9tt/x6LCiRIJXyIqQmkw9PmrT7iPuedN/OR5g/YJX0gYZI?=
 =?us-ascii?Q?4yUpo5OBmw7dJ8/o1JbGXGJE7bgHy7g8WGUw8W3pOaedQ2DyKjzX9mNPHMq1?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3209fec6-cfcd-4af5-3a4c-08db62544ec6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 03:57:24.4362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gO4UqOBqrxh1EPZr+imBCmVk8WoqzJehs8ibt43//WjML2WQWZSPDDs2YVo72I3LyIeROhAJURR4gA1G1mSFS0lgaP4BGOBkblEae64D+6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams wrote:
> Hi Ben,
> 
> Ben Cheatham wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > 
> > V2 Changes:
> >  - Added Link tags for links
> >  - removed stray unused variable
> > 
> > This patch is a follow up to the discussion at [1], and builds on Tony's
> > CXL error patch at [2].
> > 
> > The new CXL error types will use the Memory Address field in the
> > SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
> > compliant memory-mapped Downstream port. The value of the Memory Address
> > will be in the port's MMIO range, and it will not represent physical
> > (normal or persistent) memory.
> > 
> > Allow error injection for CXL 1.1 systems by skipping memory range
> > validation for CXL error injection types.
> 
> This just feels a bit too loose especially when the kernel has
> the cxl_acpi driver to perform the enumeration of CXL root ports.
> 
> I know that Terry and Robert are teaching the PCI AER core how to
> coordinate with RCRB information [1] (I still need to go dig in deeper
> on that set). I would expect ACPI EINJ could benefit from similar
> coordination and validate these addresses.
> 
> Now, is it any address in the downstream-port RCRB range that is valid,
> or only the base?

Now that I say the above, I wonder if the legacy EINJ interface is even
the right interface for CXL protocol error injection. It feels like
something that should be relative to the given 'struct cxl_port'
instance where the error is to be injected. Userspace should not need to
deal in MMIO addresses, especially in the RCH case where the RCRB is
difficult for userspace to enumerate.
