Return-Path: <linux-acpi+bounces-12426-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832FBA70B1E
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Mar 2025 21:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE38119A0A7E
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Mar 2025 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C69267F5F;
	Tue, 25 Mar 2025 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khCB68gx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88F267B9E;
	Tue, 25 Mar 2025 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933224; cv=none; b=elFYqINr8V3aMDAlrcG4zcsGU4MLpVn4nvebXZuS/RnisTr7UnCJuh/z3zV64Z1FHiljXhUyYdKorYrHPujfsA5OTmB1QXap2yt/u8gEbK2HUh0UJiieztVFoB2+Sepnb+7lhQmgXmi2AkibfM8DYqcyas1zfJlQBat8E847TTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933224; c=relaxed/simple;
	bh=tj0V8WO1QBHCvlLieT9zL79MvFmfnXHh40llfNUDrnw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZQorr3h+Gu8mPlGTBCv1gvDPOtZHRdgWI7Vv8CsATDABXhNt4Tdim2qidOnuUuuFSAOj3oL0sd1dvLQm5reEEhHtAR7wtNVHjAm4Ec9ZUxTdVChTNPCC33zqp0vDVNcNgY9akA10OgTnaXxTYQv7aRlfmIvNUQFL3VoWiHUbvmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khCB68gx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223f4c06e9fso3953795ad.1;
        Tue, 25 Mar 2025 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933222; x=1743538022; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj0V8WO1QBHCvlLieT9zL79MvFmfnXHh40llfNUDrnw=;
        b=khCB68gx2zeYn5+4lu4SLeF0W8MHPn6IkoNvdNc8dqyHC7Sw5Hv4GopsthfHMHkzTJ
         //uCIgxSf7liM3jWcQTSnfPbNzZG3PfzWDpyChqX6z9fUNdI+NakSbQ7EgjRA7MiH2F7
         A4pxL5ddHe1pmtLDLxE0mV9R/xAyxW1fztX6Jo0o1WO3k1EXcx58O7Ut564kiFUgXbc6
         5f56+RKlkmSjtn9NOpXbaiu6dQemK6GxXB4TrywNui8G/MDt3g0TKoyMhwvtKqWQjkB5
         Ea4eQyxgeVtdS+XwZiYzIFQVRi7tpLGH5QiUHz/xnzH/fSZMFzAP6LhOrvA8eXnvdVXf
         PU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933222; x=1743538022;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tj0V8WO1QBHCvlLieT9zL79MvFmfnXHh40llfNUDrnw=;
        b=doCWiTzrrC6t8e8AwDRh1wvGBisvtE9GBuscaB+Upe2Y3e5xXl8lGrB+PXVklLJi3F
         9ogzpPmAfoId14td23017+45BUU2pecsCNZanr8rwjqfszfJPkEbdSGLIPsTGSqFblVh
         qBjuAEoq88VkprzZVejopvnTO+uYUYXNJ8tqDCMq0TVeJxsDT9S+asUMvahWjQLJX7Yg
         cndZIrB3QIb4Vn4Ua8hSorKVr/hJ6HL4CPSFDohHsSik6wZMhCO+VFVr0+a7K1jJrMl+
         jy/Wh5zQqb9XN4KsJA1L6h8IM7A90mO3hpQnq4pkMeCASbu6tVWDYLLdYWaW8oERVTJp
         9ZKg==
X-Forwarded-Encrypted: i=1; AJvYcCUIyYct1DukGdkSb2JT2uMCUYMqQohpt5XujjB1mAj1cJ6dU4P8Ijuf2P4K81FJO/kmP+3HpBBB9hDHp9Ko@vger.kernel.org, AJvYcCV4AyCF871IeQXpBcLYskRScJr6g6D5PI66g49EYC1gftFm6QNDuXWoXKXq2RnikLk4oug0j8pSwAE4@vger.kernel.org
X-Gm-Message-State: AOJu0YyjbrtJLcSNxu7EeaSH5DQ8iE/DJPyQ3LAHoLaAnswpObd+rLNy
	D+vUMfnV8tAsXVy1CqLYqr4qDtcyvZVtpDdq638FwoOc2ApeGffe
X-Gm-Gg: ASbGncusKhmAeLbI10HjOEWCgLckH0hJEG1GBQCcLAerBIwriH/r/f3EnXkzTGwLTam
	BqazVVWZ3IRiJ/7j3M5JZdQz7BiLMdWSPU3cFD2j7BL8UyspNy6BCvPsjogCJ5RLwh2s729KYFK
	IAFnKo0Z4q0Z3z1/YKIT1sYzUH8tV4kqrVKrocdZqtowxRqcwJMcJl9NAcfx1cME5LZjKOdmlW4
	FuRNvdbLa6M1qhPGAEJFf8OErEA1Jib0F+Mta0g2z1GPdlH06X17L21FJkOLhOVRwy3tFYLz/wN
	oiLLJ3c7qFaboJ68qqLojwyt1ePQBvpdgEAbj0hDPRwex5W2
X-Google-Smtp-Source: AGHT+IE+lzdM+Ptk09dWS8IoLI3bFfZRmtMysmn4d27tUOZ9HPEFhuMB+8v3KUg2zEBCEiB9ShFc7A==
X-Received: by 2002:a17:902:f547:b0:225:abd2:5e5a with SMTP id d9443c01a7336-227efaa0686mr12163825ad.4.1742933222434;
        Tue, 25 Mar 2025 13:07:02 -0700 (PDT)
Received: from localhost ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da32fsm94335935ad.182.2025.03.25.13.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 13:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Mar 2025 17:06:58 -0300
Message-Id: <D8PM9ESWNN10.QARF2AMDMH6W@gmail.com>
Cc: "Mario Limonciello" <mario.limonciello@amd.com>, "Len Brown"
 <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: platform_profile: Optimize _aggregate_choices()
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Mark
 Pearson" <mpearson-lenovo@squebb.ca>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250322-pprof-opt-v1-1-105455879a82@gmail.com>
 <a66f55aa-9ee1-404b-8f78-258b307ea361@gmx.de>
In-Reply-To: <a66f55aa-9ee1-404b-8f78-258b307ea361@gmx.de>

On Tue Mar 25, 2025 at 4:36 PM -03, Armin Wolf wrote:
> Am 22.03.25 um 22:03 schrieb Kurt Borja:
>
>> Choices aggregates passed to _aggregate_choices() are already filled
>> with ones, therefore we can avoid copying a new bitmap on the first
>> iteration.
>>
>> This makes setting the PLATFORM_PROFILE_LAST bit on aggregates
>> unnecessary, so drop it as well.
>>
>> While at it, add a couple empty lines to improve style.
>>
> Please add a comment to signal future developers that the bitmap needs to=
 be filled with ones
> before being passed to _aggregate_choices().

Sure, I'll mention it in the kernel-doc for v2.

>
> With this being addressed:
>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Thank you Mario and Armin for the reviews!

--=20
 ~ Kurt

