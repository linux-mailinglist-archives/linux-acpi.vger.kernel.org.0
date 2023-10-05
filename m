Return-Path: <linux-acpi+bounces-434-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8BE7B9AB8
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 06:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 4135E1F22DA5
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 04:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBB81C35
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 04:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5m0zSTY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB557E
	for <linux-acpi@vger.kernel.org>; Thu,  5 Oct 2023 03:18:19 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C468F10F5
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 20:18:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c6052422acso60455ad.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Oct 2023 20:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696475895; x=1697080695; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=39JjdlLR/Ob31/fVR6Ru+laDW4pOFNz7rgGeZPgeKfQ=;
        b=S5m0zSTY1QnjiczQqbb95VeqX4tLLNItRRaIDyTIhzCYiiC2Jw7G6zCz97MSKPZsqe
         XKvKkFutyVetQ9OeWvQ83iZYAo55zyc1y9cXvA1YVC+ophGDz8iCYaDbojgPymQ7g3x5
         5teFKw7Bjky6mM7cPO8S9N3bPoj3gc1bmW837GlVO1An16t+N4P6s12m0VTFC5JUgmLr
         9oHxBHRoCTBTfU2at0eZoNYSnfSbf59iMOejPWhaipoOcd0ohPw4Ms69Gtnt+/BzJkuK
         ZKGd/nXzzae/0bLYfQ7T4POpvtmYcbH5JeLrXkw9He4kWMoDYEIfmMqt3bie64K02bON
         F8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696475895; x=1697080695;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39JjdlLR/Ob31/fVR6Ru+laDW4pOFNz7rgGeZPgeKfQ=;
        b=p10/AMxDMY2wHjli0liuwsXQyuKKJ3TaWTrT6tAPe19A6q4wYYB4UtY9iKuddUNt9T
         mu82XG6mkP6sqrLULz8ahLcOo+K4xR4/SNaI5xlLJCbIGVHiRc9mng23KTUUuw6O5wet
         2g98WfSBDkZKWuz/31f9+mHUpnE8iRIUGPh0VEsD+qoAIVOtXitxMxJWjsD96GVK6VCE
         KUjURVFQTaU0+nrZ0P+IK92OHBZSelSIPyW9ZMs7VGK7KCE0ZZ/RVQ4JjiONi3aBh5wr
         +7/U9qPYwOA7rP7SmWNR6E0xbmtnAWPboEkP3k9VsfmEAKM8ElV6DT2bDaL1/bFdtMTB
         ePPw==
X-Gm-Message-State: AOJu0YzNvgJMSsNf3uCvuzjrwVEnQHDWP2Ly7hGMH2P/57KLZmBTH6xC
	iyytXqoXcsbFqrzVYf8NbZ+2IA==
X-Google-Smtp-Source: AGHT+IHr1rUdKIMfcNZxGXeKhm/JyoCGaNoPh2TSwqsZ+EDy8VOlXEKAc6QTvI8czhB/ty4UD1qwxw==
X-Received: by 2002:a17:902:dad1:b0:1c3:976e:22e6 with SMTP id q17-20020a170902dad100b001c3976e22e6mr5775plx.12.1696475894451;
        Wed, 04 Oct 2023 20:18:14 -0700 (PDT)
Received: from [2620:0:1008:15:5182:fb55:9b11:9c74] ([2620:0:1008:15:5182:fb55:9b11:9c74])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7904d000000b00690daae925bsm272123pfo.51.2023.10.04.20.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 20:18:13 -0700 (PDT)
Date: Wed, 4 Oct 2023 20:18:12 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Jiaqi Yan <jiaqiyan@google.com>, "Luck, Tony" <tony.luck@intel.com>, 
    "Grimm, Jon" <jon.grimm@amd.com>, dave.hansen@linux.intel.com, 
    vilas.sridharan@amd.com
cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linuxarm@huawei.com, 
    shiju.jose@huawei.com, linux-acpi@vger.kernel.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
    naoya.horiguchi@nec.com, james.morse@arm.com, david@redhat.com, 
    jthoughton@google.com, somasundaram.a@hpe.com, erdemaktas@google.com, 
    pgonda@google.com, duenwen@google.com, mike.malvestuto@intel.com, 
    gthelen@google.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries
 for set of scrub attributes
In-Reply-To: <CACw3F539gZc0FoJLo6VvYSyZmeWZ3Pbec7AzsH+MYUJJNzQbUQ@mail.gmail.com>
Message-ID: <92f48c1c-3235-49b2-aabd-7da87ad3febc@google.com>
References: <20230915172818.761-1-shiju.jose@huawei.com> <20230915172818.761-3-shiju.jose@huawei.com> <CACw3F50jRzJnr9h7qYyD3t+6h7Uw9QMfkCkgu7a=7Lv0Tpi8Zg@mail.gmail.com> <20230922111740.000046d7@huawei.com>
 <CACw3F539gZc0FoJLo6VvYSyZmeWZ3Pbec7AzsH+MYUJJNzQbUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 27 Sep 2023, Jiaqi Yan wrote:

> > > 1. I am not aware of any chip/platform hardware that implemented the
> > > hw ps part defined in ACPI RASF/RAS2 spec. So I am curious what the
> > > RAS experts from different hardware vendors think about this. For
> > > example, Tony and Dave from Intel, Jon and Vilas from AMD. Is there
> > > any hardware platform (if allowed to disclose) that implemented ACPI
> > > RASF/RAS2? If so, will vendors continue to support the control of
> > > patrol scrubber using the ACPI spec? If not (as Tony said in [1], will
> > > the vendor consider starting some future platform?
> > >
> > > If we are unlikely to get the vendor support, creating this ACPI
> > > specific sysfs API (and the driver implementations) in Linux seems to
> > > have limited meaning.
> >
> > There is a bit of a chicken and egg problem here. Until there is
> > reasonable support in kernel (or it looks like there will be),
> > BIOS teams push back on a requirement to add the tables.
> > I'd encourage no one to bother with RASF - RAS2 is much less
> > ambiguous.
> 
> Here mainly to re-ping folks from Intel (Tony and Dave)  and AMD (Jon
> and Vilas) for your opinion on RAS2.
> 

We'll need to know from vendors, ideally at minimum from both Intel and 
AMD, whether RAS2 is the long-term vision here.  Nothing is set in stone, 
of course, but deciding whether RAS2 is the standard that we should be 
rallying around will help to guide future development including in the 
kernel.

If RAS2 is insufficient for future use cases or we would need to support 
multiple implementations in the kernel for configuring the patrol scrubber 
depending on vendor, that's great feedback to have.

I'd much rather focus on implementing something in the kernel that we have 
some clarity about the vendors supporting, especially when it comes with 
user visible interfaces, as opposed to something that may not be used long 
term.  I think that's a fair ask and that vendor feedback is required 
here?

