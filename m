Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83BA2A4F6C
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 19:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgKCSwh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Nov 2020 13:52:37 -0500
Received: from mail-bn8nam08on2044.outbound.protection.outlook.com ([40.107.100.44]:57505
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbgKCSwg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Nov 2020 13:52:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d44jnBNY9ahqfUNo1wootEhBa90ywX072foIP8R5yszzKBun/K+jvYiMybOsspbkM5JPVpFIjEANiHi5bUAqY40pMF5vaGcyXPdbTp9D8WRmbY8Fbq0omCgyKJt0TZgSKI8R5x54S/FD0UAKoYkPDilPx4WAsBoq7p99EU4p9Y57bSWBsh+w726fxvk7RT4VOLs9FTBSnMg2bulxvYjqmB/u0AZDnJ61pj83x/H0J5oZFzYJQeWLqgOwN5u9I+M9H8rS6oVTmyoY7E7WIWKbTRd/QuldQvGhqrCYwgzs/nCXdnExFOOAMODL95byMKhG3c7OiGtFGWCMT6YPSrLmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEbJkfKJwdUwKZn8iVqj8//yxp1egCNc/lnwdZg8aQk=;
 b=TLT1nal4eZJ4jW/cr6NFzVOLsQdWYaWDKrQDTNvy+5sBero4zK1la05ClgiweurO1yJChXLS85NwIX5VV4ey5fB09by54uO4FYrEfs/BXRan3Qr1PquWeyG+MCoz87Wo9/FyQPAPW1iNeHSwA4veNxLviFL7RacPUNjz9Z+jedFMw6GcclpFDu9YvkEtLXyio4L7B/e14klOPbdtSZR8fCcRV8aPSH/dSdSq/edb3trlb7Ln9hgxdpCOsalcuOeIjNs9kTBTCULwxBNzaAfGBhty+VPq/O1m17NtRIqiBU5wCJskDbczNRnFaHALabPPe++6sq0whfJ/G4C6b/6/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEbJkfKJwdUwKZn8iVqj8//yxp1egCNc/lnwdZg8aQk=;
 b=Okq3B0y4IscHViebApDPd4cbxpfmbgODT09vMUWWGuWSUBDw2BsGUm3Www6arEUs9CWAOR1fEAssJ8ogWV2pa/6sVT7a3axh3nOzArQyVHBwbTWhujnsxt8O5w7BQqpQRhRuR9T0zM0ytc+Pbjl5B+W8WKTmSyu+6Rdw7SCvEwI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 18:52:32 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::a18a:3898:84d8:1209]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::a18a:3898:84d8:1209%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 18:52:31 +0000
From:   Mark Asselstine <mark.asselstine@windriver.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: Re: [PATCH] ACPICA: avoid double free when object already has a zero reference count
Date:   Tue, 03 Nov 2020 13:52:28 -0500
Message-ID: <3462630.CrzyxZ31qj@yow-masselst-lx1>
Organization: Wind River
In-Reply-To: <MWHPR11MB1599FF403112D4C33FFEA4E5F0110@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20201028200523.111028-1-mark.asselstine@windriver.com> <5891030.cEBGB3zze1@yow-masselst-lx1> <MWHPR11MB1599FF403112D4C33FFEA4E5F0110@MWHPR11MB1599.namprd11.prod.outlook.com>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [198.84.181.245]
X-ClientProxiedBy: YQXPR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::21) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-masselst-lx1.localnet (198.84.181.245) by YQXPR01CA0092.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:41::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 18:52:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba7ca720-be7c-4856-3888-08d880299e9d
X-MS-TrafficTypeDiagnostic: MW3PR11MB4665:
X-Microsoft-Antispam-PRVS: <MW3PR11MB46652B9C8EFA4493BCEDE14DED110@MW3PR11MB4665.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYpxI/i5wUW+TJLENYCY5rYiSflovwM0k8Eake/IqRmnxSee4JRVtZX3wZHhadQJg+mw8sAqG2b68Crn0vUqdtBjTGgdxqdN9vPKeBJFnRkh227yt8EdjweCc5NJR/UhNQWcTSwpcvfLDJFwofk5A84Zmhhjr7HIsDg6rH+JgEJqx4YYvX7uA1l+EL/Z6aQl3WoFpn3hUix2cg1SLWDKmdhjueiCvnIvZ/1t8S/ePKPwtYVDAEUiQ1TlhjwIJRxad0IzXXhWuqrBUNHy6QbAvB4x7EmcQSYj+be7m/caWaHe83wQ/yviALJtGBie7p+nLDhSi/85qlQQcnZnV9C7G0bNCEociBkY5e3tXVqBisyCHmOO1uswj7m1yZBANIZN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39850400004)(346002)(376002)(53546011)(5660300002)(66556008)(6506007)(66946007)(2906002)(36916002)(4326008)(52116002)(66476007)(478600001)(956004)(16526019)(186003)(83380400001)(6512007)(26005)(110136005)(8936002)(6486002)(86362001)(44832011)(33716001)(54906003)(316002)(9686003)(8676002)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uOvpVkmnViwokOYstCI+AvKHiKi3dIHEzS6kYgNbdPdwJU4MN5xT2zj7BCa6vH4wzDFMZATr2khCqTlsussI9/8b+gWxWcY9hNowGVUvDQAH1OfxY4QnlYJg4hnK83tKwORA71lPaBf22Zp43toPKltz6taVRppK70g7AkIcmcnlKJ3wolg7u1pyH85t2OZpZSXp0Uk5wn89f9VWYT/kqR2Xv2HOohInvNkcfipnYuyfU34c+jwJIYQ6cHboOMDKqf+FA5KVLRLmIRyKMjQRd8A6y6IQv+akqaFvcnD5DTqtPFuTcVsMKPGQ4aEJz9X74FrwJAmDohM2NV2BmY6Ty38aGuIOlA1MJ1hXnXrh6uKIQyWLUiesm9q5ZCPT7pXTwwyEWkG+PEi+xrT5tNlglXEfSbWrrwqj3E+lmn3UIZSsAilQadcg/lKe6FQllwWMDddqtbpSNSSQrc6Y5u35qUYXlEkNfU9DIOFQ8/khkLg1B55wVN0va4XMo9wE0t9yc1c6IwWIKBvOjfmEOxUCQlwRvsaTZ/SSITIL3y4Uzv8nnLrcfNiqr0j2ySMhQknW7m/0HkgLKaQkK/Ww115NAiiuPjXnV3ZJHepit/F/ixAr9wSD72Y5Bkq58/e/KWBM0FLCNk13nq13Hy/TpGKbpA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7ca720-be7c-4856-3888-08d880299e9d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 18:52:31.8263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLF46DB6wCBc9DFs8u026IR86pUfVf6m6AD1CR02TRy2Di2LgPVUIS201i3kk7Cjj5d1uRLZAN50NzvPbV+J6LGSSgfJX+GQLoOoGUQAP84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4665
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, November 3, 2020 1:28:14 P.M. EST Kaneda, Erik wrote:
> 
> > -----Original Message-----
> > From: Mark Asselstine <mark.asselstine@windriver.com>
> > Sent: Monday, November 2, 2020 10:51 AM
> > To: Rafael J. Wysocki <rafael@kernel.org>; Kaneda, Erik
> > <erik.kaneda@intel.com>
> > Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Moore, Robert
> > <robert.moore@intel.com>
> > Subject: Re: [PATCH] ACPICA: avoid double free when object already has a
> > zero reference count
> > 
> > On Monday, November 2, 2020 1:11:22 P.M. EST Kaneda, Erik wrote:
> > > > -----Original Message-----
> > > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > > Sent: Thursday, October 29, 2020 7:06 AM
> > > > To: Mark Asselstine <mark.asselstine@windriver.com>
> > > > Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Kaneda, Erik
> > > > <erik.kaneda@intel.com>; Moore, Robert <robert.moore@intel.com>
> > > > Subject: Re: [PATCH] ACPICA: avoid double free when object already has
> > 
> > a
> > 
> > > > zero reference count
> > > > 
> > > > 
> > > > 
> > > > +Erik and Bob
> > > > 
> > > > 
> > > > 
> > > > On Thu, Oct 29, 2020 at 3:05 AM Mark Asselstine
> > > > 
> > > > <mark.asselstine@windriver.com> wrote:
> > > > > The first trip into acpi_ut_update_ref_count() for an object where
> > > > > 'object->common.reference_count' is 1 and we are performing a
> > > > > REF_DECREMENT will result in 'new_count' being 0 and thus the object
> > > > > is deleted via acpi_ut_delete_internal_obj().
> > > > > 
> > > > > 
> > > > > 
> > > > > If for some reason we make a subsequent trip into
> > > > > acpi_ut_update_ref_count() with the same object,
> > > > > object->common.reference_count' will be 0 and performing a
> > > > > REF_DECREMENT will produce a warning msg "Reference Count is
> > 
> > already
> > 
> > > > > zero, cannot decrement", 'new_count' will again be 0 and the already
> > > > > deleted object will be attempted to be deleted again via
> > > > > acpi_ut_delete_internal_obj().
> > > 
> > > Mark, Do you have an example of AML/ASL that you used to determine
> > 
> > this
> > 
> > > double free?
> > 
> > Unfortunately no. It is a rare occurance and a consequence of several
> > actions taking place at the same time during boot, including a PCI
> > rescan. Unfortunately due to circumstances I am sure you would rather not
> > have to be
> > concerned about, we have so far had to focus our efforts on an older
> > kernel
> > which also has the preempt-rt patchset applied. It is for this reason I
> > also didn't include the dmesg and eventual kernel BUG_ON in my
> > submission.
> > 
> > It is unclear at this time if the additional locking or other changes that
> > have been merged since the kernel version we are on would prevent this
> > from
> > occuring on an up to date kernel.
> > 
> > I have reviewed the code in the latest linux kernel and as far as I can
> > tell the deficiency is still present. If you do go into
> > acpi_ut_update_ref_count() with an object with a reference count of 0 and
> > an action of REF_DECREMENT the
> > following may be called:
> > 
> > acpi_ut_update_ref_count
> > 
> >   -> acpi_ut_delete_internal_obj
> >   
> >     -> acpi_ut_delete_object_desc
> >     
> >       -> acpi_os_release_object
> >       
> >         -> kmem_cache_free
> > 
> > I completely understand if you have concerns about the change since I
> > can't
> > hand you a reproducer. I was hoping the merrits of the change would stand
> > on
> > their own as there is no reason to call acpi_ut_delete_internal_obj() if
> > we
> > have already done so, even if the rest of the call chain was well behaved.
> > In our case the eventual slab corruption ended up affecting the
> > 'Acpi-Operand' dedicated cache. We see the corruption happen shortly
> > after we see the msg warning that the reference count is already at zero.
> > 
> > Please let me know if there is anything else I can provide to help out and
> > thanks for your time reviewing this change.
> 
> Since this is such a sensitive part of the codebase, I would like to see if
> it's possible to come up with ASL that reproduces this on our userspace
> interpreter (acpiexec).
> 
> I can try reproduce this from your explanations but it would be helpful to
> also get an acpidump and dmesg so that we can understand which named
> objects are causing this issue. This gives us a clue on how to reproduce
> this in user space.
> 
> Could you provide an acpidump of the machine and 2 dmesg logs? I need one
> normal dmesg that shows this error and a custom kernel built with
> CONFIG_ACPI_DEBUG=y and booting with the following commandline parameters:
> 
> acpi.debug_level=0x80000 acpi.debug_layer=0xffffffff

This should be possible. Give me a day or two to put something together. Again 
my intention, as when dealing with any maintainer, is to be sensitive of your 
time and given the kernel version skew and such I am not sure how well it will 
map to the latest kernel code. But if you can pull out some clues to help with 
this mapping I am not going to impede your offer of assistance.

Thanks,
MarkA

> 
> Thanks,
> Erik
> 
> > Thanks,
> > Mark
> > 
> > > Thanks,
> > > Erik
> > > 
> > > > > Since the object deletion doesn't NULL the object the calls to
> > > > > acpi_ut_delete_internal_obj(), acpi_ut_delete_object_desc(),
> > > > > acpi_os_release_object(), kmem_cache_free() will operate on the
> > 
> > object
> > 
> > > > > as if it hasn't been deleted. In many cases this can result in no
> > > > > issues, but if you are using the slab and a new object has been
> > > > > created with the same address this can be the cause slab corruption.
> > > > > 
> > > > > 
> > > > > 
> > > > > Adding a check if we are decrementing to 0 for the first time and
> > > > > only
> > > > > calling acpi_ut_delete_internal_obj() in this case will prevent
> > > > > another attempt at deleting the object.
> > > > > 
> > > > > 
> > > > > 
> > > > > Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
> > > > > ---
> > > > > 
> > > > >  drivers/acpi/acpica/utdelete.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/acpi/acpica/utdelete.c
> > > > > b/drivers/acpi/acpica/utdelete.c
> >  
> >  index 4c0d4e434196..c6b860fd9eb5
> >  
> > > > > 100644
> > > > > --- a/drivers/acpi/acpica/utdelete.c
> > > > > +++ b/drivers/acpi/acpica/utdelete.c
> > > > > @@ -421,9 +421,9 @@ acpi_ut_update_ref_count(union
> > > > 
> > > > acpi_operand_object *object, u32 action)
> > > > 
> > > > >                                       ACPI_GET_FUNCTION_NAME,
> > > > >                                       object,
> > > > >                                       object->common.type,
> > > > >                                       new_count));
> > > > > 
> > > > > -               /* Actually delete the object on a reference count
> > > > > of
> > > > > zero */
> >  
> >  +               /* If we haven't already, actually delete the
> >  
> > > > > object on a reference>
> > > > 
> > > > count of zero */
> > > > 
> > > > > -               if (new_count == 0) {
> > > > > +               if (new_count == 0 && original_count != 0) {
> > > > > 
> > > > >                         acpi_ut_delete_internal_obj(object);
> > > > >                 
> > > > >                 }
> > > > >                 message = "Decrement";
> > > > > 
> > > > > --
> > > > > 2.17.1




