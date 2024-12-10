Return-Path: <linux-acpi+bounces-10063-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A889C9EBBD8
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 22:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1117168657
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 21:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27B52343CB;
	Tue, 10 Dec 2024 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DXyME9KY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CD232396
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866071; cv=none; b=lfKkOtcPAQN8Wzg0dtdKlraydxLX2kl0e8dJ30zwFnZL+HR4RMX98dAJqRdvmH6aGJk7rPRBFE0vWuGzFvhJ4tJyaEQxjIoRtZJrNIFkGUPJx3Nag3mU5KETsDNxl0hVAWVj50YglnnOE8HKJvLni8j1wvq5HCbsoSRk1lfvbKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866071; c=relaxed/simple;
	bh=Wj6GJ2swJpdXPIA55sjM7Y0DDbLPXovMHvENa2EydwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgJBx8RZgiFq+eaaUgDgzwErUwH1XQD+yw9NoIdH1kjJTDwAzHULdOT85OwrZpCtJ2H3JxHhfemHJcsGuuzyreVTT8uKWgDSjncFZmfTgkTTtd9oF+IC10tjTO1NeOOTFr+lPyjgfr3H8I185HGyegdHOqlC/0xd2ZKiSy5jsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DXyME9KY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21631789fcdso337855ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 13:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733866069; x=1734470869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s/YuPzifs9jEt0j1RwPUAZ3kuyk16V3hz+9XJwFbKNE=;
        b=DXyME9KY0yv1wqmlZomYX4mDZ7AiFawSDt4ifPg5o1Bx1DmiJXX3OnIzRp72hLt/po
         BZLIST++vTtVPO8Lb45/8iU1OVUo6aV/72YEiBX50puytlpPA2ztC6iv0aoUHYmw/AYX
         LDFp9J8DOg87giO6ZATzFWqvP88PlbSFuSZJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866069; x=1734470869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/YuPzifs9jEt0j1RwPUAZ3kuyk16V3hz+9XJwFbKNE=;
        b=BaGyXGKAMmh/btjLGIfJs98o8PVV9+fz5dXX/85fad1Jq1CzEfketYHxySHdOas8CY
         8h6kzBpdsBslVoUYtwv7Y57puKmR7fqyy1M9TEysizc8c4ceuus1WBudp0UCKbyzkoEx
         N999SLMF2EI3kPV583IPNb8YXf5rNDoozOgVm0jcKA4S/g+tYLpX+NbUXqqMVQdJWYtK
         buZB8q8fROzhYJEujCmkhBzAgjb2d9uNH3QMFWlgy8poyFSt+vPuJX2OfRpBdSSyki+n
         IhYb0WSv5xZ46lELBzdK5dPWRbTv33GnnzDoBbDDX9EqwqVUAgri8yH9Fr8Kxe4HZE5M
         sDfA==
X-Forwarded-Encrypted: i=1; AJvYcCU2ECjjAxE16HbprS8b2snlEfNDsS6Ecj7iMhDTQOXiBPFH2o0BMmw25JGWCrWhBgDRyzuwYS3AG/dp@vger.kernel.org
X-Gm-Message-State: AOJu0YziRdFeP/6Cf0Wkir2NIkKSW+GH9cJ5cmZKlzLUha3AHlTMubR/
	7KbWX8CD1TV4c0WC0iZNcyJ1NZrQugXd2km0+HAGZRJkG4gbfZNjE3wX0nGsK9Bo2fsA37vBvGY
	=
X-Gm-Gg: ASbGncv0npA4dt619GUcyoZNT8lZA2NgEG5GFeqVWnCxFbGLEj+Il+FWdqcE6uTOtKB
	tQxgluA+gwj1Orf1Ucb5QmGTmWJyn9usVFN3rl8mB6kvIKw64mtoa5Pvy8YSkEFdv1UJ5dTcP6r
	acGN7P1wOgqS3Qi/QY6XGLwaYVYz02Y2R960pRcNRv35E+7bgllibGQhQzWhjZ3GF0GE+fY1vHN
	JSr0vxpnF1rmTD+Rkks/3OTuZ5MP7oQkjTxXrbKkft3a70QlW9MZB7oOY6sqiesRqWeW6B6gzMj
	t/mRs072W/rfb0dh
X-Google-Smtp-Source: AGHT+IGXHolndRRBmHbc20SJUZX4gm5kkIAnMuvp456PfPD+Pz3d363gyASgE+Lky1xdJhOeZxeT3A==
X-Received: by 2002:a17:902:e74f:b0:216:84f0:e33c with SMTP id d9443c01a7336-2177a2707a7mr3863045ad.20.1733866069510;
        Tue, 10 Dec 2024 13:27:49 -0800 (PST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com. [209.85.216.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2164498fb5bsm45774625ad.140.2024.12.10.13.27.45
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 13:27:45 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so50538a91.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 13:27:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZAxFTnTSmhvVixMfU7RSgJkUD/oBkZSMKu5Ad66L7rmZWuEfwWrHBmHhzDpf05zw9/76M6gAtBfZS@vger.kernel.org
X-Received: by 2002:a17:90a:b389:b0:2ef:ad27:7c1a with SMTP id
 98e67ed59e1d1-2f12878d1d1mr437693a91.2.1733866064580; Tue, 10 Dec 2024
 13:27:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org> <Z1isvGLLwr7jmW5k@kekkonen.localdomain>
In-Reply-To: <Z1isvGLLwr7jmW5k@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 22:27:32 +0100
X-Gmail-Original-Message-ID: <CANiDSCtFQBNjJoLF1VKR_M4zNHQWwWATu3p=-QQS-d3fY+9KUA@mail.gmail.com>
X-Gm-Features: AZHOrDm_vFiL0dGEzWST540Nxq4R6kmbJ8O_IagFBELPZMZsnuRVzRl-QCxx5C0
Message-ID: <CANiDSCtFQBNjJoLF1VKR_M4zNHQWwWATu3p=-QQS-d3fY+9KUA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] media: ipu-bridge: Fix warning when !ACPI
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 22:04, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Dec 10, 2024 at 07:55:58PM +0000, Ricardo Ribalda wrote:
> > One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
> > throws the following smatch warning:
> > drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> >
> > Fix it by replacing the condition.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> I've picked this to my tree and I'll take the last one, too, once the rest
> reaches the media tree.

Thanks!

If you do not mind, I will keep sending 1/7 when I send v3, to make
sure it is tested by the CI. I will mark it as duplicate in patchwork.

Thanks!

>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda

