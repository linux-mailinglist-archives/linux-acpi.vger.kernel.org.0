Return-Path: <linux-acpi+bounces-4055-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D603086DFCE
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Mar 2024 12:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108AF1C226AA
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Mar 2024 11:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963746BFCC;
	Fri,  1 Mar 2024 11:04:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAB96BFC9;
	Fri,  1 Mar 2024 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291062; cv=none; b=j7PQcl19mzzGVeoHTAKnqSUCV2ABgEzxhfvq05rWYvWo1XQV65qrAVYg8b+mt96qnw3iq9yAW4MZAwx1gMKjXhTZkFImkYLYwlkI5nvZIA483Eu/kvt0YP5UQpVbawGJFmaBndUFidNJNWL2rX38PrddELRZG5iPKK9wKGb0l+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291062; c=relaxed/simple;
	bh=sY34af5iX01O2Nt3VP+kaqLg+zUsofnNaFBh0R+AuNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAa5UT63HYCbU8Mtg6I4VcjqKSlNtqbYt4vdlFPEWm+xYHp9eW1U01YPlLK8EsR+HsM6Dc5UVaNKM8XMwTGnRONN2AR30LlCxMZNyn3LqX5HWXRvi2soF38a/7M70loM+Oqd8InrdCcQEpM8vNLyp5F1zMMHdpIa2HTvh34rTVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e2b466d213so499203a34.0;
        Fri, 01 Mar 2024 03:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291060; x=1709895860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4FD47MhM9Hy/db1+3NowmS6c7AXiiERWCqjP+qDMXk=;
        b=tFqKclrmmyhaWDBdXOTKZdt/PGjj9q+jwIK8XnG/oulHj9UGbGDA5SB0I6RfGJXuBa
         H356IkIR8b+rx3hmH/Dt0OYCpg22aFjWthFToc4ZMKRvWfWioSenKinZv87m4vOMgucd
         ooSJwrRXH/AV2Dgy6KzctvlF+gujX+igpdemPItYxvTDsg+fpO6v4IxIDN/vUAmrG7E6
         t3QWlTCRfh/37/ABl7lk/PVnK5X+FZDrsRUExTeB06NLlW6u2McV3mBRoerg0jgaxX4Y
         1LXlggRzwcah+o5DrRhwo7xNV87N051Wn5tf6fuQHQoStBYXKqgIBaeQeNfdL6XwX83H
         mprA==
X-Forwarded-Encrypted: i=1; AJvYcCWil7/eNSa3tOp4XPRTBa3Dj6Vz5dR0SAGqSAxmm1zsrFYJcdzcb7FHH3yzgy9WhT0jt9IMbgw6hQExK9IFXQeJw589wvgR+EGTXeDAx80SwiNeQpaxNU+JWcO3DAkmkV9G7qwH
X-Gm-Message-State: AOJu0Yyoq6uouAo7nancPWMmzkUcnBMbPf3TDzDgoYkLmJfZZO5WZdfW
	xovrN58HeeAQbfBpMkqi3qgONN4GXiVqPnjVTL7el9BK9HMgH0VRvnvB0hdzPNktJJs181FUU4j
	LjkeJJLYrkj5DvL13r70xgiUJR3g=
X-Google-Smtp-Source: AGHT+IGgfFsGBSK5CwMtyisGIYA+J4p4zw1wUbMyZn2P5M1Po6/SjRmJSfPQDNH78oU1JtxxMKi19B92jJCWJtv++88=
X-Received: by 2002:a4a:3441:0:b0:5a0:f488:6489 with SMTP id
 n1-20020a4a3441000000b005a0f4886489mr1254836oof.0.1709291059961; Fri, 01 Mar
 2024 03:04:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64137e23-e374-4129-8e3c-dcd7606364d4@linux.alibaba.com>
 <CAJZ5v0hG7vpWd9-pdeuNZDpDQ13MuwzgPkFnyG7TuQ=DRAMo6Q@mail.gmail.com> <cdb0f30e-b1d5-49ba-8730-740e9c06c87c@linux.alibaba.com>
In-Reply-To: <cdb0f30e-b1d5-49ba-8730-740e9c06c87c@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 1 Mar 2024 12:04:08 +0100
Message-ID: <CAJZ5v0gqcN7F+xzXPdOnYV5m7Lvoa2q8Pftv6u0=_VVA6-FrHw@mail.gmail.com>
Subject: Re: [PATCH] x86/cstate: fix mwait hint target cstate calc
To: He Rongguang <herongguang@linux.alibaba.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, jacob.jun.pan@linux.intel.com, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	shannon.zhao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:02=E2=80=AFAM He Rongguang
<herongguang@linux.alibaba.com> wrote:
>
> =E5=9C=A8 2024/3/1 1:22, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Wed, Feb 28, 2024 at 8:28=E2=80=AFAM He Rongguang
> > <herongguang@linux.alibaba.com> wrote:
> >>
> >> According to x86 manual (Intel SDM Vol 2, Table 4-11. MWAIT Hints
> >> Register (EAX) and AMD manual Vol 3, MWAIT), mwait hint[7:4] adds 1 is
> >> the corresponding cstate, and 0xF means C0, so fix the handling of
> >> 0xF -> C0.
> >>
> >> Intel: "Value of 0 means C1; 1 means C2 and so on
> >> Value of 01111B means C0".
> >>
> >> AMD: "The processor C-state is EAX[7:4]+1, so to request C0 is to plac=
e
> >> the value F in EAX[7:4] and to request C1 is to place the value 0 in
> >> EAX[7:4].".
> >
> > Yes, 0x0F is defined to correspond to C0.  However, the value in
> > question is never equal to 0x0F in any of the functions modified by
> > this patch.
> >
> > What's the purpose of the modification, then?
> >
>
> Hi, this is found when I tweak ACPI cstate table qemu presenting to VM.
>
> Usually, ACPI cstate table only contains C1+, but nothing prevents ACPI
> firmware from presenting a cstate (maybe C1+) but using a mwait address
> C0 (i.e., 0xF in ACPI FFH MWAIT hint address). And if this is the case,
> Linux erroneously treat this cstate as C16, while actually this should
> be legal C0 state.
>
> As I think ACPI firmware is out of Linux kernel scope, so I think it=E2=
=80=99s
> better for Linux kernel to implement here referring to spec, how do you
> think? :)

That's fair, but you need to put the above information into the patch
changelog.  Otherwise it is unclear why you want to make this change.

