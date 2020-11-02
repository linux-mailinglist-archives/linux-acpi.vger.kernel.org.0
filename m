Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974132A3351
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 19:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgKBSvO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 13:51:14 -0500
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:28001
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbgKBSvN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Nov 2020 13:51:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5gaNma02x4GENoSJMyST5u3xxRMFGRfjBvTrUpsVS59huHVCfWN+n6NV3LbTXEW36PGXrrQ5/yg1OYJ3ew0TJg8HMOL40aC3pvgJY8ntoZww/cOTHGEwXW+jipm2f5NNVLPFXFT4exxnDKtVIStTXxHuFm/Ua2OVSCdwckFZXrSRezuAkYPO9Sj2SJRtgP78mdCKT4oIEGXilS3X+f8aD945fE+gCyYwSYANJr6EopeNxLZoPhLsyFL4SbO087VC+y1QlcOu44D5DGpJZVaE5QXCeMDEXnJ5IC0lhUjNqaIirsBtpRLLQwpnJ1UIcF0f6KvLk57Ap5Was7JQcPlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7d/4POo+z1NDPe6aLlF0lty6ZLR1ScJAQfUGL7ag6o=;
 b=J/0XB+c6PkgHxEbS5FNbR3IFEG2xja0Ebs1ufcM4HNC42/Sp5v6bhrKVVm8mJazhhkft6Wu2EBbJGITkJA9XsFOgR/VM1NneSvhztcO7l4fSXs/sn6I3PiDkcXE+s2Hork8DDonZIHFdfiGuMRmlMUYUeR6yrkDBu9htAETYLQSV8dHsLMIYjUff2LfbYGR4PsnNfyoYbxnsP5H2xI3wwMfr7Aw8YAUDLzQNhPgdEikpUVEo1SFNQTezvS2R7yjolQKIYwqALm0WYeaH349eOFleiIrmsnmsOB2WqDaLxYfmuuy0vSSy797iCcCiymk0cu3NR+3V5XJH/UGVCmXAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7d/4POo+z1NDPe6aLlF0lty6ZLR1ScJAQfUGL7ag6o=;
 b=Ugzku1iILxrasuO1FaA/osnR/fUEOrIjBlRU+i/fVQcv4Qik8kKz7wsgdwaxaJ0hIBFNyCdAZEFLooHnTfd/isKO4vGT/y4sVEp7DprssxJ3OYAPDddNspg4lCj1p3Oc0Q6KR7ueLFrJhLby25Fds6NHKYNJdLfhknqP++OTvpM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MWHPR11MB0062.namprd11.prod.outlook.com (2603:10b6:301:67::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 2 Nov
 2020 18:51:09 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::a18a:3898:84d8:1209]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::a18a:3898:84d8:1209%5]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 18:51:09 +0000
From:   Mark Asselstine <mark.asselstine@windriver.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: Re: [PATCH] ACPICA: avoid double free when object already has a zero reference count
Date:   Mon, 02 Nov 2020 13:51:05 -0500
Message-ID: <5891030.cEBGB3zze1@yow-masselst-lx1>
Organization: Wind River
In-Reply-To: <MWHPR11MB15993189246B6AC609247D69F0100@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20201028200523.111028-1-mark.asselstine@windriver.com> <CAJZ5v0hr4xFA9bGJM+0e4i-QpESPnwy5ZT4KPwfJgby5Sz3UBw@mail.gmail.com> <MWHPR11MB15993189246B6AC609247D69F0100@MWHPR11MB1599.namprd11.prod.outlook.com>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [198.84.181.245]
X-ClientProxiedBy: YQXPR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::22) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-masselst-lx1.localnet (198.84.181.245) by YQXPR01CA0093.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:41::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 18:51:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec378fa9-65f8-4074-cbaf-08d87f6042e2
X-MS-TrafficTypeDiagnostic: MWHPR11MB0062:
X-Microsoft-Antispam-PRVS: <MWHPR11MB0062E2DA4341BEDAE0DAF2F8ED100@MWHPR11MB0062.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnDTyPUU0tuFnj2kMtsYNan6qxXmnJDKu9Nyhj2K/wV1JbmjnBM+uSlFGPd1VDXNWPdfPP6ocI5E8KuArJdforveUieQamGKg9C/EHvlLkLtVyaysUL4uDgB5PFYIuiE9ONGRzN4unjZwfvKfSWWIR+sCznJ+2BYKUctGeWiKtwDsOUOOmQDUknaeCQ+kiDQdUiXPUDaVaK0BE+sABg99pKnUSI4JseqslHg08joXt7BDin58ydiyR+ePoP4kmIGk0GvQnkE2Ss9tALBNy+iGRQQDPHfQAKfa2ptRdhKIinPx79H5i0wC3XazjuX0IcYZuiqDi3owaMP43jlnhz8gD7PyF/+F//rGmAnMci9dDz2mEL71X9OYMdxZu/2QRTC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39850400004)(6666004)(52116002)(16526019)(53546011)(6506007)(44832011)(5660300002)(186003)(36916002)(26005)(316002)(956004)(83380400001)(2906002)(54906003)(66476007)(66556008)(478600001)(66946007)(86362001)(8676002)(6486002)(6512007)(9686003)(4326008)(110136005)(33716001)(8936002)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XDRf7yBn27jBUp43uhLekS42C6qk0EEU49IzXpbiWqV+wgz/nZ+ts2yw2GlyOpgwMGAz+rFqevppySlwYpSHiQJYEJjpkt8q0B3+n/IOwWVLhlBh1BraFNhruf+tzB9UDAaS6lZSWH+qoToIxlTzQaSP3SQNGCgVgQXm69srn0qqy4wrdJOT0hs2dTiaqBl3TF7V6CQgatrUs4921z1q8gIGrJ16S87wrM2otyp/4JJzil2W6NuytHgJYFHPbatE0QlwON6k7xUbNyz8t/fAU30piLw2vLTYb126RdeW8rnDLWU5XIm49/GcL0WEvl2lRHNJQew8TXaeLPmFrYrowek9NwwFtkjdtoP1/svih//4z73qXIrG+K6t88jmaH6UlxHMzjtD5zHoo49i8JhhqK9XwBv1EiCToPKnMg5pY7l6YYMU29NAcxh74dHmsDUUfxII9+amdJSkaVD/7uks1EOgC5jXVisbKzz+O9dbuRk/tDtNB01kPkx9n1XefKLuGhXp+yznOn5F54CIBxO2pYHsIgDYsPSksEIiRNTMmZf6Rx4+Qhc37AZN3Hig3KKt7LSw9qX1US18MwsXdH61EM+QCq1Nr6LG/FtrdooToNYeC6XLme/Rs+skC7okUCbFgfkF8CPeDB8wzJ6mn+X5aA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec378fa9-65f8-4074-cbaf-08d87f6042e2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 18:51:09.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qELMP3uE+cgt55rdcjMtCjILRt5B7KnwS/j7fp+XfjkY7NEZN8RezmxFxoEeYvgX4QXSxNsYaJj3NfOtyNLfA9gmj3vDkLwab5mbr3DVilw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0062
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, November 2, 2020 1:11:22 P.M. EST Kaneda, Erik wrote:
> 
> 
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Thursday, October 29, 2020 7:06 AM
> > To: Mark Asselstine <mark.asselstine@windriver.com>
> > Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Kaneda, Erik
> > <erik.kaneda@intel.com>; Moore, Robert <robert.moore@intel.com>
> > Subject: Re: [PATCH] ACPICA: avoid double free when object already has a
> > zero reference count
> >
> >
> >
> > +Erik and Bob
> >
> >
> >
> > On Thu, Oct 29, 2020 at 3:05 AM Mark Asselstine
> > <mark.asselstine@windriver.com> wrote:
> > 
> > >
> > >
> > > The first trip into acpi_ut_update_ref_count() for an object where
> > > 'object->common.reference_count' is 1 and we are performing a
> > > REF_DECREMENT will result in 'new_count' being 0 and thus the object
> > > is deleted via acpi_ut_delete_internal_obj().
> > >
> > >
> > >
> > > If for some reason we make a subsequent trip into
> > > acpi_ut_update_ref_count() with the same object,
> > > object->common.reference_count' will be 0 and performing a
> > > REF_DECREMENT will produce a warning msg "Reference Count is already
> > > zero, cannot decrement", 'new_count' will again be 0 and the already
> > > deleted object will be attempted to be deleted again via
> > > acpi_ut_delete_internal_obj().
> 
> 
> Mark, Do you have an example of AML/ASL that you used to determine this
> double free?

Unfortunately no. It is a rare occurance and a consequence of several actions 
taking place at the same time during boot, including a PCI rescan. 
Unfortunately due to circumstances I am sure you would rather not have to be 
concerned about, we have so far had to focus our efforts on an older kernel 
which also has the preempt-rt patchset applied. It is for this reason I also 
didn't include the dmesg and eventual kernel BUG_ON in my submission.

It is unclear at this time if the additional locking or other changes that 
have been merged since the kernel version we are on would prevent this from 
occuring on an up to date kernel.

I have reviewed the code in the latest linux kernel and as far as I can tell 
the deficiency is still present. If you do go into acpi_ut_update_ref_count() 
with an object with a reference count of 0 and an action of REF_DECREMENT the 
following may be called:

acpi_ut_update_ref_count
  -> acpi_ut_delete_internal_obj
    -> acpi_ut_delete_object_desc
      -> acpi_os_release_object
        -> kmem_cache_free

I completely understand if you have concerns about the change since I can't 
hand you a reproducer. I was hoping the merrits of the change would stand on 
their own as there is no reason to call acpi_ut_delete_internal_obj() if we 
have already done so, even if the rest of the call chain was well behaved. In 
our case the eventual slab corruption ended up affecting the 'Acpi-Operand' 
dedicated cache. We see the corruption happen shortly after we see the msg 
warning that the reference count is already at zero.

Please let me know if there is anything else I can provide to help out and 
thanks for your time reviewing this change.

Thanks,
Mark

 
> Thanks,
> Erik
> 
> 
> > >
> > >
> > > Since the object deletion doesn't NULL the object the calls to
> > > acpi_ut_delete_internal_obj(), acpi_ut_delete_object_desc(),
> > > acpi_os_release_object(), kmem_cache_free() will operate on the object
> > > as if it hasn't been deleted. In many cases this can result in no
> > > issues, but if you are using the slab and a new object has been
> > > created with the same address this can be the cause slab corruption.
> > >
> > >
> > >
> > > Adding a check if we are decrementing to 0 for the first time and only
> > > calling acpi_ut_delete_internal_obj() in this case will prevent
> > > another attempt at deleting the object.
> > >
> > >
> > >
> > > Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
> > > ---
> > > 
> > >  drivers/acpi/acpica/utdelete.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > >
> > >
> > > diff --git a/drivers/acpi/acpica/utdelete.c
> > > b/drivers/acpi/acpica/utdelete.c
 index 4c0d4e434196..c6b860fd9eb5
> > > 100644
> > > --- a/drivers/acpi/acpica/utdelete.c
> > > +++ b/drivers/acpi/acpica/utdelete.c
> > > @@ -421,9 +421,9 @@ acpi_ut_update_ref_count(union
> > 
> > acpi_operand_object *object, u32 action)
> > 
> > >                                       ACPI_GET_FUNCTION_NAME, object,
> > >                                       object->common.type, new_count));
> > >
> > >
> > >
> > > -               /* Actually delete the object on a reference count of
> > > zero */
 +               /* If we haven't already, actually delete the
> > > object on a reference> 
> > count of zero */
> > 
> > >
> > >
> > > -               if (new_count == 0) {
> > > +               if (new_count == 0 && original_count != 0) {
> > > 
> > >                         acpi_ut_delete_internal_obj(object);
> > >                 
> > >                 }
> > >                 message = "Decrement";
> > > 
> > > --
> > > 2.17.1
> > >
> > >




