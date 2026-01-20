Return-Path: <linux-acpi+bounces-20476-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F8kLzTFb2mhMQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20476-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 19:11:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9024928D
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 19:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35C5A90D3C8
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 16:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889924611FF;
	Tue, 20 Jan 2026 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4lHA8HEE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D074611F8
	for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2026 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926534; cv=pass; b=oi/3eD0Oy+Kxdw4vUjhwi7eyLieuuZsnHHiUwShukF/XsGQC9yJou7ZHGhuzPPl66AxXw/zwQxrwFnkUb4pJebi1r7VO3v7Ikxe7G2kjvhRFHNuuVtad1Urpzz8kkrGyD8qif87dTYgIuD0XA+0KHzhFOLknoC/hQ9WJSArfIwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926534; c=relaxed/simple;
	bh=2NdbYcVwZi1ih+onTl3vtMwhcrSn8T+MqEL2Cz0G25Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZtnvCKHHuTQruzclcnLkzqNh9bTAvpxU+K4Vfn6BmHmjtnuJ720e5zSbUGlZJTy2sdd1bZyzfqrUF2nO6U33kchEe7xz62ad8dymD4rZOgDgT4WDLwxlXE60Ct1+vaTh/VqgE7ZpQgj3HyyQbhegLGahTIyPVDogfklH/RUhds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4lHA8HEE; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4801cf7c2c7so147035e9.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2026 08:28:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768926531; cv=none;
        d=google.com; s=arc-20240605;
        b=NxBA/fnl3uCeyNIOZ5yIv8pzJhBUTzhroxCaXjEll23wVa1eZDOAbyDzip2d3yaIsu
         vmrJIgtcKAk2/bPu3QEniKqFo8RfPH9VzzgYutCAF4gAHAl6M4JuOvaHivGKXGI/s7EY
         2pUTgwz2K96PR3ZFSOOJ71QgiFi/mIWNfKiBQNW+jVvWZu+LRzv0hJUZgbAQU/K9pQvx
         G+CNly6jArdD62lgtqjKcZFB7WW3KMVlXM3VOGjzEYvia2qpFwf4OMHtNW21mi5slC1J
         amXCTnW7S50/US2PLdBB7yAb/dMtYi/mxNHM6JkNWuAIR7WqUsjBeMpoB6fl2PVJhfpz
         mwEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2NdbYcVwZi1ih+onTl3vtMwhcrSn8T+MqEL2Cz0G25Q=;
        fh=JRfxEEtZKvpTXO6pYLmQD/VDjBbg7vGxXO3HSsf7y1A=;
        b=b91HpEdQ/x07hAXJ/VY9xtnA0/zR8HDEuh2lwobgS8Ug/ktmPImpdEhb1BdMucX5hY
         j8CI4DRng/Bl+XAC9yHp2OoW5zYTRhzhDxEQPHM3UpjbqdgfO75+CLU4YQvcTi0lTs3j
         S867LZhAUV5s9k/mX8YIXIkzcusXy5AwXCEiiWzLw0jWowvFxSTxqAIcejmsayJMaV+s
         6a5CVUOgfnmZB8ZkUOK6Cljt7mgEP3P2l6eKhohlVj9kBhZ9vGkUNx+x9seUmT17kOff
         iM6IFJBJzCCM+FK4cfHf9MMQxBPY9lLYVmgh8ITxcupRVoNuYgxaAGGca0DRTuhj7clq
         TPYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768926531; x=1769531331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NdbYcVwZi1ih+onTl3vtMwhcrSn8T+MqEL2Cz0G25Q=;
        b=4lHA8HEEeZgP/YUBLDBV82SFnUFOrX7ylbWOuMGnNSNoaKA04+jhRgmZ+qhYOYg99+
         4/q0soxE3Pa2XFcrYLmgKbAlJzzUeXdCerbKtzNXuFNh8r+/cTLMnFBao6OJleTZCeIz
         7ZaN1ml6p0rnTuTI8HhEKdPtwtLvCZI/E10j4e3HUipvZOeye4xd57FoHWSkO5k0Jg9w
         HaS35CLHn17cCXxobQzdoK4p7kDuKI73MP/UC6nfSP6Ged813+pG2rFFedOjIIWn2T9I
         JhJM5JOb/kOG+hZf3ZnrAuZ2+p5MpEP7yBAo4Y5RiLM9Ie9JT+0EVbUUcW/ZVoJ9Ub/R
         hIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768926531; x=1769531331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NdbYcVwZi1ih+onTl3vtMwhcrSn8T+MqEL2Cz0G25Q=;
        b=JxLW9t+/eKoCL3CjDlOwv3Y0K26GovBsPWItFfHgnTLSmtRIVUPnGjExgOg7NOnQu2
         gMMnkmApUarcXsbz6qLJHa51MjXkh5oyO+lRgmspi9Mf+U6v4t59QQMUKk7NVcv+WwHo
         a+Uov/73fIDhwnzqiLYJkua11qgwDsQIBydmMp7S5LcTlU5QXyG4iQrL6aCJJiCAm1t3
         mcASMwMM2IslC/9OZTTWUMnkrCz/ouGPDzUczj3+ow1KNliNsjxzELuyYMl5PJUUHGeB
         TfgbvuqHLiYobcO4fZbQu/ljPy/WbsN7FZ+z2NkgPUTGDKQi3e2/5YhffjXe+4g0kbUF
         IFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDkO+p9rLyhBeXPkgSfVZmrLVMZaAcDY0DTPka1XrJzdB75sOxTn7d5dU4Ca6sx708Z1GQcBx8jJW7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/d4KhHN0o8L3namYfswZPXUIrstU8dayoRBsabSJqxbEHcZuB
	P/gBhmrqzTz1YaZiJ2M8rNgjfBDyITyZQMwdgE4LU7VTS72i5Ou0VLvmz5oPB0/0avoYJr2921f
	NGGOgpkEzdnmqxE0L1Ed0q6GmsTascaCbNi5Buope
X-Gm-Gg: AY/fxX7esrhdNz1ZJSQyV7PTjc/CQ/koRpDDIDXureZdbc83unpV8tTKMQIGJ/905r7
	tBrnS1x53Mulp7lor5s//5cEBYdurkEHYHv947ac12lmvrcSXzlc2nRwMba44COw5TGEnaSeoUA
	Wdn+pPb4sbWL4t+WR4eH4wL4De1Nc3573na3tQwnNGw94Y28ktpSFsqDge9ZxnJuFrDQneqZZvE
	fVycttRMeaE2J6AKJQt2d0lTTbfsU9rU75MyJbTYNzBDR3CoWwenzOfXd6XleRff/K5xQdgipAI
	vdNTJnit1uBLSh40i8hzOGO8Oiu+
X-Received: by 2002:a05:600c:198b:b0:47e:dc0a:8591 with SMTP id
 5b1f17b1804b1-4802788e239mr2686005e9.2.1768926530251; Tue, 20 Jan 2026
 08:28:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102184434.2406-1-ankita@nvidia.com> <CACw3F51k=sFtXB1JE3HCcXP6EA0Tt4Yf44VUi3JLz0bgW-aArQ@mail.gmail.com>
 <SA1PR12MB71997E2E101E55CDE65EA6B3B08AA@SA1PR12MB7199.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB71997E2E101E55CDE65EA6B3B08AA@SA1PR12MB7199.namprd12.prod.outlook.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 20 Jan 2026 08:28:38 -0800
X-Gm-Features: AZwV_Qi-sOyZ-R41AFqxYbo27tCfgIMGnJS7jLDAEJnKTv2-_C3tqbgzg63dbdA
Message-ID: <CACw3F51qrBXnN370Btk7=bcKU7s44nmQYfN=EAfq25MondRUNA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mm: Implement ECC handling for pfn with no struct page
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Aniket Agashe <aniketa@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Matt Ochs <mochs@nvidia.com>, 
	Shameer Kolothum <skolothumtho@nvidia.com>, "linmiaohe@huawei.com" <linmiaohe@huawei.com>, 
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@redhat.com" <david@redhat.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"tony.luck@intel.com" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"rafael@kernel.org" <rafael@kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>, 
	"mchehab@kernel.org" <mchehab@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "alex@shazbot.org" <alex@shazbot.org>, Neo Jia <cjia@nvidia.com>, 
	Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
	Dheeraj Nigam <dnigam@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>, 
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>, 
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20476-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[nvidia.com,huawei.com,gmail.com,linux-foundation.org,redhat.com,oracle.com,suse.cz,kernel.org,google.com,suse.com,intel.com,alien8.de,shazbot.org,vger.kernel.org,kvack.org,amd.com,baylibre.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiaqiyan@google.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4E9024928D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Jan 16, 2026 at 9:36=E2=80=AFPM Ankit Agrawal <ankita@nvidia.com> w=
rote:
>
> >>
> >> v2 -> v3
> >> - Rebased to v6.17-rc7.
> >> - Skipped the unmapping of PFNMAP during reception of poison. Suggeste=
d by
> >> Jason Gunthorpe, Jiaqi Yan, Vikram Sethi (Thanks!)
> >> - Updated the check to prevent multiple registration to the same PFN
> >> range using interval_tree_iter_first. Thanks Shameer Kolothum for the
> >> suggestion.
> >> - Removed the callback function in the nvgrace-gpu requiring tracking =
of
> >> poisoned PFN as it isn't required anymore.
> >
> > Hi Ankit,
> >
> >
> > I get that for nvgrace-gpu driver, you removed pfn_address_space_ops
> > because there is no need to unmap poisoned HBM page.
> >
> > What about the nvgrace-egm driver? Now that you removed the
> > pfn_address_space_ops callback from pfn_address_space in [1], how can
> > nvgrace-egm driver know the poisoned EGM pages at runtime?
> >
> > I expect the functionality to return retired pages should also include
> > runtime poisoned pages, which are not in the list queried from
> > egm-retired-pages-data-base during initialization. Or maybe my
> > expection is wrong/obsolete?
>
> Hi Jiaqi, yes the EGM code will include consideration for runtime
> poisoned pages as well. It will now instead make use of the
> pfn_to_vma_pgoff callback merged through https://github.com/torvalds/linu=
x/commit/e6dbcb7c0e7b508d443a9aa6f77f63a2f83b1ae4

Thank you! Sorry I wasn't following that thread closely and missed it.

>
> > [1] https://lore.kernel.org/linux-mm/20230920140210.12663-2-ankita@nvid=
ia.com
> > [2] https://lore.kernel.org/kvm/20250904040828.319452-12-ankita@nvidia.=
com
>

