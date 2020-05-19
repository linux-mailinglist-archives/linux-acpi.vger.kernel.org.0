Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56471D8E1E
	for <lists+linux-acpi@lfdr.de>; Tue, 19 May 2020 05:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgESDPS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 May 2020 23:15:18 -0400
Received: from mail-eopbgr1300072.outbound.protection.outlook.com ([40.107.130.72]:48096
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbgESDPR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 May 2020 23:15:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1Q3a/QhBQgNHc+5T6/U72mayONzlRzKfYWn2ssZxtRH3e4jXs2lOZa6mI11UAgERUY1XtTPGj847occzbEXEOvwUTxLkOI2wpP7KjRzv3842gjXlqiIiNfcfzQC8a/ilAlx9SJF7mqhjNQwehQLhs5ORI+TAdNQKLkiScN17X/u6piEl776ojrzmdVBQjZql2ROYyy0hbcb+/fBKE1b3Rx82upiLOtzHeTNsTd+yA3o1pY4py0Q1t7YK0p+aLtvxqjY3FrEm2XYrI+SXv3vm7ERG1JRiAWwjheBYJ6Rb10OaUuI6hWkD+VCIqYDzGPlIdzcYpLe9fDJ2I6TZ+7XDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWqOyqeRr1mwEo+b86cueOyFMF89zN6DpRX+1siARnI=;
 b=GJcC7vE/vvRNfO5JOaLiMDDlvP3bB3+45+9Df3e7pVJRFif0yOWxhBFhazLObMGEHQ8QSwMHsoygrW6VELUAZqqh0w2DOyrEmT63wD8sSj+6MIyqCirvH0lnuxQ43hF5HwJAW36Rj5d5lJXF6Z/NiV8/4S2ua8n3rPZPv+EeH3x/ulmT2yWbiyH2ai1fa7s7zkwnWVLvoKg9gNbBV4/tFVUGul1XSZ7lzjPlTdPPxHoMpmTlQIvQ5pK6JEDsTOzDj181QMeZdGE13M9JPRkXKLPHo27t6QEuWbTLwVGVMl+URJmi2Nzjv7U6StGEcHIldJQr5q3z+EuDalSxlBFPdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWqOyqeRr1mwEo+b86cueOyFMF89zN6DpRX+1siARnI=;
 b=Cbka+AmrgC0RXsr9a+8ZHjcVhafzGjt5xF/iouCSThc2NlsEysgvudsSnbWhwiEHZDyZ/xTcwKi6Ylzg1Uv6pgcLdOsSgDZRHDQbSJdiCQnyXiBGN2BJfWH1JtPiWUoPJqb4iGX2Ve6q8Ojj1HQX4hNl1FbvxGzjMlfQNnviuxU=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB4058.jpnprd01.prod.outlook.com (2603:1096:404:d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 03:15:11 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58%5]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 03:15:11 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        James Morse <james.morse@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tyler Baicar <tyler@amperecomputing.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
Subject: Re: [PATCH v2 1/3] mm/memory-failure: Add memory_failure_queue_kick()
Thread-Topic: [PATCH v2 1/3] mm/memory-failure: Add
 memory_failure_queue_kick()
Thread-Index: AQHWH9gLTSNZrBgxpkSNHu3+w+LRAKit5J6AgAB5FgCAAHoFgA==
Date:   Tue, 19 May 2020 03:15:11 +0000
Message-ID: <20200519031511.GA31023@hori.linux.bs1.fc.nec.co.jp>
References: <20200501164543.24423-1-james.morse@arm.com>
 <20200501164543.24423-2-james.morse@arm.com> <49686237.p6yG9EJavU@kreacher>
 <20200518125828.e4e3973c743556e976c5ee65@linux-foundation.org>
In-Reply-To: <20200518125828.e4e3973c743556e976c5ee65@linux-foundation.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nec.com;
x-originating-ip: [165.225.110.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d15019ed-8d7d-4003-ef8f-08d7fba2d790
x-ms-traffictypediagnostic: TY2PR01MB4058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB4058E3EA651A3AB5220DC146E7B90@TY2PR01MB4058.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0epd9lO8SuCSp6kp6qDTZOBwQ/H01gnqYY2+iqPikTej57FGhzjELrK8UpOFXJuY2+Zj0U6QcXdQ2dh3GRGDwg9yr4adLgd2bWqQr0lQVuVyIzn+9hmja4VINA0U9xB/ifrAFvoI6hqbp/7c7DdDviPnu4vPeo7cXCJXlRQNYsI3ymInLC1cxEnogh27bO8iPQTiSgXgWy79QwEYPRXhOSWzSeLrkdXum/0yFRJ/nQvAft8Nryt2sPAqzKg+RUezZdTdGC8j9MDrLFXyYjGtBeavYeXL+kjD+qX6w4cHmAdaqJU6ouJExuhKDoFi6tkR76xfX0zEgqU7TE53HnLpDVez+0rOnMZulT3jp3TFnGdl34ofntpmsTwTXQzVkFDdzjB9QbGy1nc6FG+gslWkPCEGKkyaGji1nUKQY9YNbmhjlRT4gQMm/56/gL0D8abC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(4326008)(6916009)(6486002)(33656002)(2906002)(478600001)(9686003)(6512007)(85182001)(7416002)(55236004)(86362001)(6506007)(53546011)(186003)(71200400001)(26005)(54906003)(8676002)(8936002)(76116006)(66946007)(1076003)(66556008)(66476007)(64756008)(66446008)(316002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: H4Al6d4lzlRJV4PxA+0GyiwedT2kOU88gyFMEzidHTUt78x0hBq71PI15smD9WKOvBoyaFroQXBBHAZxBCHhEDEpm7nZQCP8XWjrvFir9RBzF49947W7EP/dJ7HQVi+J+2qXhV5Eu9gRhgR0+/AglB7IU4OGNcjERDOhDhgHrzc68XKG8eQdYm5g7Dr//jRGqjVO8mbKdcZgjKYl0AWhs3g8l7DGSm0dfVu4ij0k0n94wXSg9gnCQJADvPiiKWEgV1CtyvJAZgGMZJRVnwQmMZY+Q9pCGpaFG7Ygpo3fMSp/LgtT73XDDC2tly+JN7ym+FA8jAbCh5bQs5bVv3Uk868uG55sEjXHuhY9wr5qMJzAUvw67oGVY5X88oVvvyp/zRjabYrqHXKwuQyUS/7VMLvnqsAwOzANyuDzJ8GRWfi+KwoQQgI4G4CGxcF93zlulA9Ff0Fj65jHGLxazcXf2HWGlslpTGLk2Yj6d4BsD5HqDtyLlfY9anq33+FbJHJz
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <E059626AE2FD5A41A7AAE8C323888CDB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15019ed-8d7d-4003-ef8f-08d7fba2d790
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 03:15:11.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQ7zlTk2hJucDJ4dbMCEfOQ/m6pShI0AbSr/Kt6OwtuEsHqXKLDNFwJWrhDBeV+uj4LT65nCP/CBXfqjcFciJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4058
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 18, 2020 at 12:58:28PM -0700, Andrew Morton wrote:
> On Mon, 18 May 2020 14:45:05 +0200 "Rafael J. Wysocki" <rjw@rjwysocki.net=
> wrote:
>=20
> > On Friday, May 1, 2020 6:45:41 PM CEST James Morse wrote:
> > > The GHES code calls memory_failure_queue() from IRQ context to schedu=
le
> > > work on the current CPU so that memory_failure() can sleep.
> > >=20
> > > For synchronous memory errors the arch code needs to know any signals
> > > that memory_failure() will trigger are pending before it returns to
> > > user-space, possibly when exiting from the IRQ.
> > >=20
> > > Add a helper to kick the memory failure queue, to ensure the schedule=
d
> > > work has happened. This has to be called from process context, so may
> > > have been migrated from the original cpu. Pass the cpu the work was
> > > queued on.
> > >=20
> > > Change memory_failure_work_func() to permit being called on the 'wron=
g'
> > > cpu.
> > >=20
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -3012,6 +3012,7 @@ enum mf_flags {
> > >  };
> > >  extern int memory_failure(unsigned long pfn, int flags);
> > >  extern void memory_failure_queue(unsigned long pfn, int flags);
> > > +extern void memory_failure_queue_kick(int cpu);
> > >  extern int unpoison_memory(unsigned long pfn);
> > >  extern int get_hwpoison_page(struct page *page);
> > >  #define put_hwpoison_page(page)	put_page(page)
> > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > index a96364be8ab4..c4afb407bf0f 100644
> > > --- a/mm/memory-failure.c
> > > +++ b/mm/memory-failure.c
> > > @@ -1493,7 +1493,7 @@ static void memory_failure_work_func(struct wor=
k_struct *work)
> > >  	unsigned long proc_flags;
> > >  	int gotten;
> > > =20
> > > -	mf_cpu =3D this_cpu_ptr(&memory_failure_cpu);
> > > +	mf_cpu =3D container_of(work, struct memory_failure_cpu, work);
> > >  	for (;;) {
> > >  		spin_lock_irqsave(&mf_cpu->lock, proc_flags);
> > >  		gotten =3D kfifo_get(&mf_cpu->fifo, &entry);
> > > @@ -1507,6 +1507,19 @@ static void memory_failure_work_func(struct wo=
rk_struct *work)
> > >  	}
> > >  }
> > > =20
> > > +/*
> > > + * Process memory_failure work queued on the specified CPU.
> > > + * Used to avoid return-to-userspace racing with the memory_failure =
workqueue.
> > > + */
> > > +void memory_failure_queue_kick(int cpu)
> > > +{
> > > +	struct memory_failure_cpu *mf_cpu;
> > > +
> > > +	mf_cpu =3D &per_cpu(memory_failure_cpu, cpu);
> > > +	cancel_work_sync(&mf_cpu->work);
> > > +	memory_failure_work_func(&mf_cpu->work);
> > > +}
> > > +
> > >  static int __init memory_failure_init(void)
> > >  {
> > >  	struct memory_failure_cpu *mf_cpu;
> > >=20
> >=20
> > I could apply this provided an ACK from the mm people.
> >=20
>=20
> Naoya Horiguchi is the memory-failure.c person.  A review would be
> appreciated please?
>=20
> I'm struggling with it a bit.  memory_failure_queue_kick() should be
> called on the cpu which is identified by arg `cpu', yes?=20
> memory_failure_work_func() appears to assume this.
>=20
> If that's right then a) why bother passing in the `cpu' arg?  and b)
> what keeps this thread pinned to that CPU?  cancel_work_sync() can
> schedule.

If I read correctly, memory_failure work is queue on the CPU on which the
user process ran when it touched the corrupted memory, and the process can
be scheduled on another CPU when the kernel returned back to userspace afte=
r
handling the GHES event.  So we need to remember where the memory_failure
event is queued to flush proper work queue.  So I feel that this properly
implements it.

Considering the effect to the other caller, currently memory_failure_queue(=
)
has 2 callers, ghes_handle_memory_failure() and cec_add_elem(). The former
is what we try to change now.  And the latter is to execute soft offline
(which is related to corrected non-fatal errors), so that's not affected by
the reported issue.  So I don't think that this change breaks the other
caller.

So I'm fine with the suggested change.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Thanks,
Naoya Horiguchi=
