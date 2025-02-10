Return-Path: <linux-acpi+bounces-10958-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37347A2F013
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 15:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50511647E0
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825B725291E;
	Mon, 10 Feb 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lauwhUoz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC111DF744;
	Mon, 10 Feb 2025 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198620; cv=none; b=dPL2pK4QepLLYFQv9wNzdr982tEmqsapcm2r+VtdLZVwS4M8fxUbPLvWiTo0QHE2lHMTZE+epCAPdInDQgdUCpNUw4ZGZYT5vyvBJg70aXhfr7YhloV+1YWhbadTcjAeXn4wjyHFCRFNkULBZKXQCbPpxoXzIHEjS5fgksclWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198620; c=relaxed/simple;
	bh=nHoYfNKhhoT3vf+Hkt6XjU50Dxv43v0nONLNd50W4Ic=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hQbmEjVt+iG7Pt1uhUVa7ViAmH/5w+yvgqpPTMZJOndIzZPN/JN310xoah56otgLwnpC8cNklYNEr2De1H33PQybWXyGOX+s/39s4C5UcYhSyKQuv+/hSp/lh/zWibfTqVQkHVGd2fbpkleg1A+lfIhSDN0BXEyY/XUsrzI8Wfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lauwhUoz; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f3ac0c8053so679513b6e.1;
        Mon, 10 Feb 2025 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739198618; x=1739803418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l8tH1+anqpxV4+UCFmyR34QdkgyYEvstsVqzCpPlu3E=;
        b=lauwhUoz/vnCFZg9EWt/E4MF7bB5rDIqgi6LIjX6iQPFLj3mwh5A4fc5ssn0hQbSrD
         JP12ymqYOlVh6buOsjmqy4Va8BE6FJP2Q89jfncTPKLX8SEXHKqs319dAYxJFDJ6T1U8
         F3yaprT4bhGiCVRMYSulN7Vznwto+eSspjeyp8DyNnqEZvhV1GXVyv5ydqC1oPbt4Gcy
         +MBk28WGTubgmx182WuQUFGDgXS7rvDyJH75lMscO/zHNG/ai7kIq9GLJP9CVGiC8C0M
         QJ1/SU5tvrlHSfp9mRtnx/8fVMvNEemAjmW2qw/cGDoCg/tFPQIrt8kQtCjaDke7D0QL
         Whjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739198618; x=1739803418;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8tH1+anqpxV4+UCFmyR34QdkgyYEvstsVqzCpPlu3E=;
        b=mJe8PTucVqn/AGNBg0swRKMnRISnxQ6/ZSC/HKDRWA+dHia6I26/vzXOOSNDmpKx3Y
         rJ1pvee2X8LixpDUduKPPAOPyLUNV2A9jFddJi8HvKfauLwcHJ/RTyCT4CtC7C1wHNDs
         2eTYOrlfl/v2gr9XTTicwWQg/Js0IkB4tgHp1M/0tcPxWAdU+Dv4OsoTXZTUTABG51/e
         XSQ6bwkOPXKNgN7nidcYxAcpJbxzUDgnTGLIWkuzmwpRHON8WvoZKAXE+e9VvmCoDxQA
         5resZSlectGsGEGHKeluXrXBaFrqUTwEfc6vusBVGlnrf9RSGvwlqDWT4CeWQEtEHKW7
         NBmA==
X-Forwarded-Encrypted: i=1; AJvYcCUz7WwC2Z5suNQeJNuTE61UYfSFeJ+BuHVrESVVji5x7NxmmyECqXrYaXAVsnq6LVcyn6VACGnxV2o=@vger.kernel.org, AJvYcCX9MUTm6qcYoTItc4+NF6uxYKEQEiVY4gCgYzDUU19VZX7sqXpHXx0S5NU3xdLEo0hLRBtZjGddOLlG@vger.kernel.org
X-Gm-Message-State: AOJu0YwWckUSDCNGflIjzH0ybHdbm0umi5osOy03NVpOJ/YDUGSq3/nI
	W/jbrqXP0nnpAHPHra9ZdvMxuQo0vMNgSX6PrMLiShVaj4LBfPzbkrsHY+BwGYyRiev+k/mwdEg
	F+grQdU7BLhl4Z0qvNA4SjJ72uI/6e5pZ/Po=
X-Gm-Gg: ASbGncvNirIK77C6LzuLqKgXwJfTCnmm69kIAUiSCFTlGa/1JlOoOVl67EPyHovR+0K
	isxqMVwZC6QHmt1RimnVLWOUlCK5VxQfURvKoCIUyhEa5wiDwdh1oliTdHS/k8E7eAvA6QhA=
X-Google-Smtp-Source: AGHT+IHkx6qjX2e3X7Z7mNj5ETjaqiTcauT+GvkaDiGOO1ScPb8ezFb0C74hZwrBh87y52pGRQ00++Jzi4jIQSw5+h4=
X-Received: by 2002:a05:6808:1396:b0:3eb:3d1b:4876 with SMTP id
 5614622812f47-3f39237a354mr8260413b6e.32.1739198617945; Mon, 10 Feb 2025
 06:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: K G <kaushik.ghose@gmail.com>
Date: Mon, 10 Feb 2025 09:43:27 -0500
X-Gm-Features: AWEUYZlCFuzJTaroPBCWU1rtXCJzAK6dCHXQWugQDWsDE-eQXZnTJ2A8baGP6_4
Message-ID: <CAOZQhKiYsB3AyRLH2td1sGX+CTbJji5+FGtd+X3wZV7ton38UQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] ACPI: battery: Wake system on AC plug or unplug in
 over s2idle
To: superm1@kernel.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	mario.limonciello@amd.com, pavel@ucw.cz, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

As only a mildly technical Linux user, I would rather this not be
rolled out as the default behavior. In case this fixes issues some
users are having, I would prefer this to be enabled via a bootup
option that is documented somewhere so that only affected users can
use it. FWIW I'm on  6.8.0-51-generic on a ThinkPad E14 G4 and the
power plugin/plugout behavior is just fine. Thank you.

