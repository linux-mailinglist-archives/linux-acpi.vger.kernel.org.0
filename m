Return-Path: <linux-acpi+bounces-20481-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NQNOmdpcGkVXwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20481-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 06:51:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB6051B7E
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 06:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5FD64A5115
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 05:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E89A3D413E;
	Wed, 21 Jan 2026 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fzktm2V0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E45634D4D6
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jan 2026 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974682; cv=pass; b=mWGwQq7flv3SThyexUGVNB6mXE0yItzaTH4G1wW5ZXsHVm2PC+TlzakruheOmchabc2xu+qtyV+53ThsRQfpu3vavu9gBRq4kX30QWnsZ9F4xVvmXlaaOku0KZGtACNXfr+MZbhWOcHDPoy23VyybJqo47SxKikGv/eFHP3r/Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974682; c=relaxed/simple;
	bh=6vdWFdg0sDT5jGzlnooDJHQGt6SwRkysCk75zY2WxtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyXehwZArl2lNdvT9YK2nw9gexqxsD8GvEvVwAaojACBTiG5fJjOANp0oFkg30rRsFnU6AYtV5N1UbM9oqxIpopcENQ9vJfo5cDU4/cXaw6BBSqTXLqE1/H4AyoFjnw4ftb2y5rtxds1l8pf7Ot5JV/ZhOn//6kdngHb4YEn6jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fzktm2V0; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee730612dso46955e9.0
        for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2026 21:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768974679; cv=none;
        d=google.com; s=arc-20240605;
        b=NfnqlRr1Nfx6CsKHf+XhgZQ/jlfleJMmo0pDXDZ6r2KFRl3ziHQV6OQmTe5cj5BobY
         6EvHj2LFcr44mFB9huxscVQiOA8HBA7vTnudjSKOf624aCAtt7E/eLppCfCkmON1GTl+
         4Q7KXbIoa5mzYUbX6+P6P5qAuu6qRczZFfL5xs9BCGSVVO+Sxz8GVPk/SxsNyr8WwiWR
         Mj4+kZummZNQrrXdu85sBs5+a1dfzZvuY0IKgJItTwIP6gCi4g3a/4oK7tNDK0q9fNW1
         DKgI1h1tQGGQz7x1ol4C6HqiAVAP+hF+fkPtPGiTxzItUK8cFQGKdASrmo2zKSOk6mvA
         pgGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6vdWFdg0sDT5jGzlnooDJHQGt6SwRkysCk75zY2WxtU=;
        fh=igThM7qd1fU9S+OrJt3pxktkovowGg4U6UIVpFGZeHw=;
        b=fyfiREqNuFBJqkO4OW8Z4+8lwncpcj8ZpRV44GKkDNIND6PjVl8OEHRU7IJabY/946
         xvIF1kmTgDLWHHikQB1gOmg3kyrHecBaFoE+Yj6TVM/5JMC/cl2zceV8pcuw0Olg04Eu
         VDe/B8t4YisPYB0wYzck4NMx1dnhDOOOyKu/g5fISHc7k5zujJ/78G6NZt+BiQXxg3/M
         z2/CDfvi6QuA4XxrQ+vP4daDRFZw/2XhYaL+Gs+jZIO8/COLDibE+Tk+Ji/pCnacClOk
         8PJmHCcQ9lPWrZnRjKfk2f58YXqLAOvr+njme0cH7utzh/4m/+Wy7tE3sVO4kt1B1EXo
         PQfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768974679; x=1769579479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vdWFdg0sDT5jGzlnooDJHQGt6SwRkysCk75zY2WxtU=;
        b=Fzktm2V0/f3RiRVqNd8r5aVN3qgiJexDV49Id2wNmpLp66AiGvkPwmFOdwlacpPuAw
         KRLpeiDZ3jO6ZbMLPKb0lNxx0ikiJyVXfYir1tLFuzEAFawbQQfrEdX7HV3Q6YDpx2We
         pGDWUXKLO+Z7B/9012FKnJm4APSW3hC4NcIiXsrw9z1WgUkkeW3/7E2R6t5n6CDpNlXb
         g/QUMZJ2TnAkCGs2J2AFsyA3gNf/yIPyNLYRLgMVDlMmisfgMGXdluHiaj5Z7KaBGL7N
         F0e+0WsktYsyByQ/Rrhm1oDwtuqvxSmZGB53Viur662jKHe2iFwnDRGA5XOI3933C+oJ
         3djQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768974679; x=1769579479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6vdWFdg0sDT5jGzlnooDJHQGt6SwRkysCk75zY2WxtU=;
        b=ew83CiCGKYJ/Ns65lY4BbHaQbCmMfAyKIM/zMiyU8pgcN0SXnkBGPIuzwXWUKzAt3w
         iVC2vRuffwleZPq02LQVRnacdU7wDoHe8+N6ob718dpY/SjgiabwjlR+u3kydPXYkaCn
         q4YsW5jHkvWSXaGhqqiOb/BRPHYdsv/LVvgOYB6Kb3g8fw8xzMQk4kEKWSV6WcxpkJVJ
         Rns36WtqvjyFwljt3mMQLytl/u7bDXX2qxxwcqy19QeWLJ1QLvJStGE6W6OELjVy2fsQ
         6HbmA6alTbprdSkOO4ZwAQSxHTh8TtkIX1RlxPYqtB6IX9QF74io+Z5RXqJZQWJadPKL
         8iOg==
X-Forwarded-Encrypted: i=1; AJvYcCUP5x9lj3DlWCixYQO1wz9gyLh//keUKMfTxkiAkoxl8a61HVJX5AWhCFyAJ3zO60CAxblYu/H7iyov@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAkPHBTut9BHfh2m/Ov3nsN9LXs7M5Hwl13q2bqKmeAKPz63m
	5v47Uls197hCkaGGWZSYozCXlboG/Ia7Ow6jnWFULTI1G9+Kvsd1bj8X7kh0/7DLZ0o8SxiAbT4
	7QXPWALFAPIouWV4eNTbVM8qmelsuGSaVAba5iYh/
X-Gm-Gg: AZuq6aJJVRuMakxbNf4xTapFFptM72TmfBLyijaW5859OphhlyjRE1ENDzTWjvLCbdI
	6KHhuZVSIN6xp218V9pHeL2qXIEOeYTSV1PP16H+I57B3ydT0pKGqWaWrZ/BOOiXRrwRFbCUTb1
	houYhMyausDvI0Q9ZTtd2zyNFqXEoQdYMouLBiwsU5FSkunLXAT1gsCulDKBNSIKZNkDaJ+QHVY
	hp8RDIWkAsaboN+ZmQMMp9WFgTdENpJha0sKXK0q9yyomzuVbX78MPfzt2z842xZxNowTp80PYG
	0ffcF2/2ac0/6gG0aQAGr3TiignR
X-Received: by 2002:a05:600c:3d97:b0:475:da0c:38a8 with SMTP id
 5b1f17b1804b1-480425622f1mr695955e9.4.1768974679127; Tue, 20 Jan 2026
 21:51:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102184434.2406-1-ankita@nvidia.com> <CACw3F51k=sFtXB1JE3HCcXP6EA0Tt4Yf44VUi3JLz0bgW-aArQ@mail.gmail.com>
 <SA1PR12MB71997E2E101E55CDE65EA6B3B08AA@SA1PR12MB7199.namprd12.prod.outlook.com>
 <CACw3F51qrBXnN370Btk7=bcKU7s44nmQYfN=EAfq25MondRUNA@mail.gmail.com>
In-Reply-To: <CACw3F51qrBXnN370Btk7=bcKU7s44nmQYfN=EAfq25MondRUNA@mail.gmail.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 20 Jan 2026 21:51:07 -0800
X-Gm-Features: AZwV_QgaTupq6DBMCeoCVM1hXfaRoAYoBx_XZxcQfdu6RhES7vwnX4BR3BC4bEE
Message-ID: <CACw3F53n1ieCfP7Dye96S1WPpein+x6wTVUhE4aVkRG=VppC-g@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20481-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 8DB6051B7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 8:28=E2=80=AFAM Jiaqi Yan <jiaqiyan@google.com> wro=
te:
>
> On Fri, Jan 16, 2026 at 9:36=E2=80=AFPM Ankit Agrawal <ankita@nvidia.com>=
 wrote:
> >
> > >>
> > >> v2 -> v3
> > >> - Rebased to v6.17-rc7.
> > >> - Skipped the unmapping of PFNMAP during reception of poison. Sugges=
ted by
> > >> Jason Gunthorpe, Jiaqi Yan, Vikram Sethi (Thanks!)
> > >> - Updated the check to prevent multiple registration to the same PFN
> > >> range using interval_tree_iter_first. Thanks Shameer Kolothum for th=
e
> > >> suggestion.
> > >> - Removed the callback function in the nvgrace-gpu requiring trackin=
g of
> > >> poisoned PFN as it isn't required anymore.
> > >
> > > Hi Ankit,
> > >
> > >
> > > I get that for nvgrace-gpu driver, you removed pfn_address_space_ops
> > > because there is no need to unmap poisoned HBM page.
> > >
> > > What about the nvgrace-egm driver? Now that you removed the
> > > pfn_address_space_ops callback from pfn_address_space in [1], how can
> > > nvgrace-egm driver know the poisoned EGM pages at runtime?
> > >
> > > I expect the functionality to return retired pages should also includ=
e
> > > runtime poisoned pages, which are not in the list queried from
> > > egm-retired-pages-data-base during initialization. Or maybe my
> > > expection is wrong/obsolete?
> >
> > Hi Jiaqi, yes the EGM code will include consideration for runtime
> > poisoned pages as well. It will now instead make use of the
> > pfn_to_vma_pgoff callback merged through https://github.com/torvalds/li=
nux/commit/e6dbcb7c0e7b508d443a9aa6f77f63a2f83b1ae4
>
> Thank you! Sorry I wasn't following that thread closely and missed it.

Sorry, one more quesiton. I saw [3] implemented pfn_to_vma_pgoff
callback in nvgrace gpu driver. Is EGM driver's callback posted
somewhere?

[3] https://lore.kernel.org/all/20251211070603.338701-2-ankita@nvidia.com/T=
/#mcc9ccec90b1ca755ad9af0a821f5ce524fed0ffc


>
> >
> > > [1] https://lore.kernel.org/linux-mm/20230920140210.12663-2-ankita@nv=
idia.com
> > > [2] https://lore.kernel.org/kvm/20250904040828.319452-12-ankita@nvidi=
a.com
> >

