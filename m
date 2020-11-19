Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD012B9DB0
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 23:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgKSWbF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Nov 2020 17:31:05 -0500
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:14063
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726342AbgKSWbF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Nov 2020 17:31:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUH3bxUz8jXadcZ9zPkasIrGuakrr5IiFrXhkhI0uXYi9/Qibv/3K8zGV/cEpPXmKN+s8pC0vDIEzXJJzrFsSPxZcxXo72/ulq63IMf54HDa9Wmg+7aKNHzFHXRW9tyBW+BMY1Cx9x5QN4rybGRyV6zDyDoU6dPW6vPG0Kt880P84ZejsO+lRkPQXXG95THCgxessoFSOn72s1ydBeeObOqsQYnUHxBV6V+6IZ4xXiEXwi263vr8xeYG9MJYrybNTNFVBTRzRV4LysFf2NyNlLcy1vFiBym0gYwTzkxxsc3OSdfdiuUex1OWbKru//6rLrt3oob5gnHswUDGYZMz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q477OrEjWIyr4YQZaDc3Nw+a/8sX7aOG+H4XOBqxcQw=;
 b=MM79TaujighdnkdPOSIu1a8zIRGKw2JEzTeDjrhbWcnQDMelWpZtmNnqKKGldLMNd9UKUxpzPAa28tdUxqnIu82kyDLyzFjtZu606OYd1eY5hGTVNqF8SbQs0gBLasmlBuTbiw9e5g7qi3xMB1G7pq5ZImNDuxO7kFTfjoPE3Fu58pQe371fTc/TmYLevk3byeXRnAv438w2HRRbClhtRAFm1QLqeQnT4Haq1fHukvpbd6shb3dp6/6U0gkHfdjAUTunS6938HyxlBFKCvMHjsVpUi6IHgY02asj94l8vKnVUWTQySkd0s1Qc4JJHW5axJHVxyytnb403OgGUdcgVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q477OrEjWIyr4YQZaDc3Nw+a/8sX7aOG+H4XOBqxcQw=;
 b=mLIm+SrQdMVqIA7DOgjK2u0lwp4s82cGAPraDz79WsJz0rzvV6v/Gup2S5xKZMWx1uRBLfu2cNJUuBVguCkWaNKKE0jDuGsexBuJJarXceu+AwuudxusltVlkYKkPkFskOhFi8eBui+qAmKsnHqbOYYM2EEOkiQufrC6ZPyEH38=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MWHPR11MB1917.namprd11.prod.outlook.com (2603:10b6:300:112::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Thu, 19 Nov
 2020 22:31:00 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::b0be:dd8a:fd4e:a711]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::b0be:dd8a:fd4e:a711%3]) with mapi id 15.20.3589.024; Thu, 19 Nov 2020
 22:31:00 +0000
From:   Mark Asselstine <mark.asselstine@windriver.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: Re: [PATCH] ACPICA: avoid double free when object already has a zero reference count
Date:   Thu, 19 Nov 2020 17:30:57 -0500
Message-ID: <17800999.geO5KgaWL5@yow-masselst-lx1>
Organization: Wind River
In-Reply-To: <3462630.CrzyxZ31qj@yow-masselst-lx1>
References: <20201028200523.111028-1-mark.asselstine@windriver.com> <MWHPR11MB1599FF403112D4C33FFEA4E5F0110@MWHPR11MB1599.namprd11.prod.outlook.com> <3462630.CrzyxZ31qj@yow-masselst-lx1>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [198.84.181.245]
X-ClientProxiedBy: YQXPR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::35) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-masselst-lx1.localnet (198.84.181.245) by YQXPR01CA0106.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:41::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 22:31:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d1ec545-9fb4-4b76-fb2c-08d88cdacadf
X-MS-TrafficTypeDiagnostic: MWHPR11MB1917:
X-Microsoft-Antispam-PRVS: <MWHPR11MB19170F67140539407E10B417EDE00@MWHPR11MB1917.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cg+0ueYH+TAWiCI1aN2rRbu47bEfQvC9/SPOjts/nGexrewqVCM7k00e20QtXSu4wSPwaVu+TH/EhsPipvfRcy49YqfQFtSaiGIMF/lqnDfBxO6djfRw7iS83NI/AP3Er14onnTgEz9YNxx9Te5NzoB73hIE8WWabztxMqDI8s1XtCsSXGFjIZUy/1Gemm4nfo2SfP1PqCaX34upohImdwYTKEeq4FQEhpY83omXrKo94XOH+fYVMPogu4SxERJ7g+xPE1BbylnKGhTksWcTJn4zy4z2TRlcuMqk9csRc3szEvrk9k0c+Gkb5XT1KVg5xsHr8SCrceO1zkXMBdXpW4HQhqPi7CkytnLWfZeC2Qpii8/17hH80ASZbzl1R68a/NRG3LUctfQmU3ga6nc3yA0RjDMVvcTJ6pYE6ta7QSwP7MzJaGd/aQ0W4FIEflL9QfPRuhI8k2+fSLUgg6LDbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(396003)(366004)(376002)(346002)(2906002)(33716001)(6506007)(83380400001)(52116002)(316002)(6666004)(5660300002)(966005)(9686003)(956004)(4326008)(66946007)(6512007)(8676002)(86362001)(8936002)(478600001)(66556008)(66476007)(26005)(186003)(44832011)(6486002)(54906003)(110136005)(16526019)(53546011)(36916002)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vl6kyedrhvR3BQA72fAMPel4p5EomLkHLRHQGMHMHtU8gmKGt3wemfyiuXsKWVts6BqdFgQQPWz4Rv3X7XKwDEk0Sux/D9607A7JJuerRnwmm+220jlsSPvHTsKtJFAFXH78Pi1qdFMeVl1/8wZHk/7yD+NEgoDnpVt4Oz6XZ+BaeM/zK4FZYZ9SxUWPWfoHjxqJVsJqZJGaFdluKx6xQZ5eyLzUdTofa+leasyv4YwPCBEphQUOnoC6GQYqvnoU8pSPDAs64bY2Zffb0CnukiFSTuzLaJvDYZT+8Q5BiwsuL5y+h9ReQaw20L6IQHUcyVXLTjBdQSpPgmob3XCV/mmtp6UoCz25F9ufP757aasjCS0En1qdtvlZ9chDBlWpD8TJVB2Qe+f3FaT/kUB2RHAeOyP0/8XtbkY6Vs7mBS7XXaaaoQdjKvI9xCRO1A6TRO8J2x0T+DsWDwYXABYdfNlLNTNFxAfvQqlONLJRfC4q8c8OxbPQDUzBREOsTZYpWAGl+7IhpZ1uPYslWDXBs5Eo72D/BH8m1ZlnlE8UBGGnzaEjPTpEHU7KJ+geJ5LtvhXQPwhKjxAIXDPdxQ3POCCvBZxDJmP5e8kZYIZe0qFz/0zozq0fA6tLImrg4TANa2B0Da5ZxOye4prssSh5dw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1ec545-9fb4-4b76-fb2c-08d88cdacadf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 22:31:00.8336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gd0X8pklQIBlJM22g3XwPZ4tMVKRBvUpQ24EmRQ6v60ypM8GD7J0ran6T2XheE2SFMsKjmfodM/jWpC2K5+nPIVVd8IrBnAs92xVtTP0WII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1917
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, November 3, 2020 1:52:28 P.M. EST Mark Asselstine wrote:
> On Tuesday, November 3, 2020 1:28:14 P.M. EST Kaneda, Erik wrote:
> > > -----Original Message-----
> > > From: Mark Asselstine <mark.asselstine@windriver.com>
> > > Sent: Monday, November 2, 2020 10:51 AM
> > > To: Rafael J. Wysocki <rafael@kernel.org>; Kaneda, Erik
> > > <erik.kaneda@intel.com>
> > > Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Moore, Robert
> > > <robert.moore@intel.com>
> > > Subject: Re: [PATCH] ACPICA: avoid double free when object already has a
> > > zero reference count
> > > 
> > > On Monday, November 2, 2020 1:11:22 P.M. EST Kaneda, Erik wrote:
> > > > > -----Original Message-----
> > > > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > > > Sent: Thursday, October 29, 2020 7:06 AM
> > > > > To: Mark Asselstine <mark.asselstine@windriver.com>
> > > > > Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Kaneda,
> > > > > Erik
> > > > > <erik.kaneda@intel.com>; Moore, Robert <robert.moore@intel.com>
> > > > > Subject: Re: [PATCH] ACPICA: avoid double free when object already
> > > > > has
> > > 
> > > a
> > > 
> > > > > zero reference count
> > > > > 
> > > > > 
> > > > > 
> > > > > +Erik and Bob
> > > > > 
> > > > > 
> > > > > 
> > > > > On Thu, Oct 29, 2020 at 3:05 AM Mark Asselstine
> > > > > 
> > > > > <mark.asselstine@windriver.com> wrote:
> > > > > > The first trip into acpi_ut_update_ref_count() for an object where
> > > > > > 'object->common.reference_count' is 1 and we are performing a
> > > > > > REF_DECREMENT will result in 'new_count' being 0 and thus the
> > > > > > object
> > > > > > is deleted via acpi_ut_delete_internal_obj().
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > If for some reason we make a subsequent trip into
> > > > > > acpi_ut_update_ref_count() with the same object,
> > > > > > object->common.reference_count' will be 0 and performing a
> > > > > > REF_DECREMENT will produce a warning msg "Reference Count is
> > > 
> > > already
> > > 
> > > > > > zero, cannot decrement", 'new_count' will again be 0 and the
> > > > > > already
> > > > > > deleted object will be attempted to be deleted again via
> > > > > > acpi_ut_delete_internal_obj().
> > > > 
> > > > Mark, Do you have an example of AML/ASL that you used to determine
> > > 
> > > this
> > > 
> > > > double free?
> > > 
> > > Unfortunately no. It is a rare occurance and a consequence of several
> > > actions taking place at the same time during boot, including a PCI
> > > rescan. Unfortunately due to circumstances I am sure you would rather
> > > not
> > > have to be
> > > concerned about, we have so far had to focus our efforts on an older
> > > kernel
> > > which also has the preempt-rt patchset applied. It is for this reason I
> > > also didn't include the dmesg and eventual kernel BUG_ON in my
> > > submission.
> > > 
> > > It is unclear at this time if the additional locking or other changes
> > > that
> > > have been merged since the kernel version we are on would prevent this
> > > from
> > > occuring on an up to date kernel.
> > > 
> > > I have reviewed the code in the latest linux kernel and as far as I can
> > > tell the deficiency is still present. If you do go into
> > > acpi_ut_update_ref_count() with an object with a reference count of 0
> > > and
> > > an action of REF_DECREMENT the
> > > following may be called:
> > > 
> > > acpi_ut_update_ref_count
> > > 
> > >   -> acpi_ut_delete_internal_obj
> > >   
> > >     -> acpi_ut_delete_object_desc
> > >     
> > >       -> acpi_os_release_object
> > >       
> > >         -> kmem_cache_free
> > > 
> > > I completely understand if you have concerns about the change since I
> > > can't
> > > hand you a reproducer. I was hoping the merrits of the change would
> > > stand
> > > on
> > > their own as there is no reason to call acpi_ut_delete_internal_obj() if
> > > we
> > > have already done so, even if the rest of the call chain was well
> > > behaved.
> > > In our case the eventual slab corruption ended up affecting the
> > > 'Acpi-Operand' dedicated cache. We see the corruption happen shortly
> > > after we see the msg warning that the reference count is already at
> > > zero.
> > > 
> > > Please let me know if there is anything else I can provide to help out
> > > and
> > > thanks for your time reviewing this change.
> > 
> > Since this is such a sensitive part of the codebase, I would like to see
> > if
> > it's possible to come up with ASL that reproduces this on our userspace
> > interpreter (acpiexec).
> > 
> > I can try reproduce this from your explanations but it would be helpful to
> > also get an acpidump and dmesg so that we can understand which named
> > objects are causing this issue. This gives us a clue on how to reproduce
> > this in user space.
> > 
> > Could you provide an acpidump of the machine and 2 dmesg logs? I need one
> > normal dmesg that shows this error and a custom kernel built with
> > CONFIG_ACPI_DEBUG=y and booting with the following commandline parameters:
> > 
> > acpi.debug_level=0x80000 acpi.debug_layer=0xffffffff
> 
> This should be possible. Give me a day or two to put something together.
> Again my intention, as when dealing with any maintainer, is to be sensitive
> of your time and given the kernel version skew and such I am not sure how
> well it will map to the latest kernel code. But if you can pull out some
> clues to help with this mapping I am not going to impede your offer of
> assistance.

I have supplied what I could directly to the Intel folks. Unfortunately, as I 
had stated previously our reproduction case uses an older kernel so can't 
easily map to the current state of code in mainline.

I go back to my original assertion that the same condition which is being 
caught by the warning should be used to prevent a second attempt at deleting 
an already deleted object. Attempting a second deletion has been observed to 
be troublesome as the underlying memory could now be in used by a valid object 
and slab corruption is highly likely.

I have also supplied a github pull request to the acpica repo as this issue 
could also manifest itself negatively in other OSes.

https://github.com/acpica/acpica/pull/652

Mark

> 
> Thanks,
> MarkA
> 
> > Thanks,
> > Erik
> > 
> > > Thanks,
> > > Mark
> > > 
> > > > Thanks,
> > > > Erik
> > > > 
> > > > > > Since the object deletion doesn't NULL the object the calls to
> > > > > > acpi_ut_delete_internal_obj(), acpi_ut_delete_object_desc(),
> > > > > > acpi_os_release_object(), kmem_cache_free() will operate on the
> > > 
> > > object
> > > 
> > > > > > as if it hasn't been deleted. In many cases this can result in no
> > > > > > issues, but if you are using the slab and a new object has been
> > > > > > created with the same address this can be the cause slab
> > > > > > corruption.
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > Adding a check if we are decrementing to 0 for the first time and
> > > > > > only
> > > > > > calling acpi_ut_delete_internal_obj() in this case will prevent
> > > > > > another attempt at deleting the object.
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
> > > > > > ---
> > > > > > 
> > > > > >  drivers/acpi/acpica/utdelete.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/acpi/acpica/utdelete.c
> > > > > > b/drivers/acpi/acpica/utdelete.c
> > >  
> > >  index 4c0d4e434196..c6b860fd9eb5
> > >  
> > > > > > 100644
> > > > > > --- a/drivers/acpi/acpica/utdelete.c
> > > > > > +++ b/drivers/acpi/acpica/utdelete.c
> > > > > > @@ -421,9 +421,9 @@ acpi_ut_update_ref_count(union
> > > > > 
> > > > > acpi_operand_object *object, u32 action)
> > > > > 
> > > > > >                                       ACPI_GET_FUNCTION_NAME,
> > > > > >                                       object,
> > > > > >                                       object->common.type,
> > > > > >                                       new_count));
> > > > > > 
> > > > > > -               /* Actually delete the object on a reference count
> > > > > > of
> > > > > > zero */
> > >  
> > >  +               /* If we haven't already, actually delete the
> > >  
> > > > > > object on a reference>
> > > > > 
> > > > > count of zero */
> > > > > 
> > > > > > -               if (new_count == 0) {
> > > > > > +               if (new_count == 0 && original_count != 0) {
> > > > > > 
> > > > > >                         acpi_ut_delete_internal_obj(object);
> > > > > >                 
> > > > > >                 }
> > > > > >                 message = "Decrement";
> > > > > > 
> > > > > > --
> > > > > > 2.17.1




