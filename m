Return-Path: <linux-acpi+bounces-14158-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CDBACF322
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 17:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03E47A1298
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBFD84E1C;
	Thu,  5 Jun 2025 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buPR9/2u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE158D2FB
	for <linux-acpi@vger.kernel.org>; Thu,  5 Jun 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749137722; cv=none; b=ncQrYIkVk4cfP215Lirwyt3h0Sq/qa6X54+ggSgfdlhowo8smZH+ar8cy4xLZ1/2MyGTAFmwHUicp5bz1uzUZi66e7mmSF+2jXRnutrZDSqpnAn0Qqfp70to6rhQ4j6KYvFX4Qsv/uvp/kbXxgWWNfL7OnjzJnAtqrkwt4unjIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749137722; c=relaxed/simple;
	bh=PabdidyP4NaRipTa2zwLZ60C9FmAviV1zEm0duJFP1Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aNdXRGB6+qVfscZqN4rBUWlNxzRisd+0o7RUAnsiWLDKXI4EQ8WRqyWFCJMk+/pC7ZgjDwP0d954dZtnaNrVBFzSvVtn1wv/f0+brLdSOqnOFVdjL0tF7FxVSTcdVF9BnrVfbumhOGwyywpCKHrGdL/vHKq4ALFmtrQ16Pla4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buPR9/2u; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2da3c572a0bso691105fac.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Jun 2025 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749137720; x=1749742520; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PabdidyP4NaRipTa2zwLZ60C9FmAviV1zEm0duJFP1Y=;
        b=buPR9/2ubNMv71NEjChGATe91bkB4iD+bGM93FIcgwXUOF3sPg3oWE9ryeQHkIdlx4
         vXUpWpIRM3tvSbUF4GInED4TjZqEXiezc7QylNONmduKmRZlH2ukaTVmWCD5F5DrHjiU
         Jxyb9TkQdyTIZLyLqZVAvQPnf8QfyLaF0jON5J4OOLxdrhqoiB2Hg+skVmYmIxsZzXl2
         rE2yniwjxbz1opgnjOrqXSf/Oq+njN5Up74ptZ38+BdkoQjRCp8BrEk4uv2u35TNUxxa
         bG2q+4/z0PJWvh5mBNeTJE5Uds6LpWb2gW1PP4uUo6QzheoBWp7hCARKuslysqUhxI/F
         d7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749137720; x=1749742520;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PabdidyP4NaRipTa2zwLZ60C9FmAviV1zEm0duJFP1Y=;
        b=E07gOnaeBT+xiFlY5HKLJlWhmxMtxZvh1KXOODmgWqvCUZtE3nrExSwA9fXihLYY9p
         qFl7I8aEUaB/a1pGgMUqU6zdGxG64/M73rJ45D1/BDKoR0OzicUrvkwoJyTRmrgjKxPZ
         4Nb5x+C+uVOcCbyoLyYoOHvWeIK3GMeKmMLZKipi3hYVPD6cu6wwKUijHPYuOx7Tol6V
         oOC4W8GdyYGM7u9oi7IeRojTqUl7aN9PRdkEH19oXKUd61VHpRnDaa2TqvEfdcTby9Lk
         cyU774yyGJQQ48ZcHcdR5ZUk2JPJn5mQpeK25+k8AaRHEdNq8j95ZG/Bn0rswBI86bCQ
         GhZQ==
X-Gm-Message-State: AOJu0Yzo9Mw58epsyJtWUGTOkAaEgd6tw3VPHq7JuZ00ytjqtvVJTJt/
	vBFfbL1Ib86A5PQlkg2pXODfj6RmGiGotKr24hI4BMwpEiNpfrfMTMpLSUMwQuc03UYaJn802Ze
	4A0cY7m3jlCWJ6z+YeH2u3kcvPHD+RQ/4Ig5i
X-Gm-Gg: ASbGncsYmBNHcYmzAAmoS0Nlfs24ccdy9rLhGhHf7Ykn2BzbG6n5wUwRvg4q9f7I9k8
	37pkFjJVNnkaI33WTnBeO0QvQog/CIYZYRlfeGOQH62PnFGXTtjJG8o0zomkJ5B0zXmljm+fSDV
	7Tck3WaW5D0jBswtpMhWQjoKh3Aw187bOzR9kGc/7FbuIlGlMNnn+y3dwlNmG6OiiGIg==
X-Google-Smtp-Source: AGHT+IGEcMxj+LTFkexOsxfBQWrqJwZ6qx30H/hcJh7qg7Na8J3AW6zEDO9h+rYpY6cyoEmLzdygVVi50jLQ5EmL71Q=
X-Received: by 2002:a05:6870:ac25:b0:29e:3921:b1ea with SMTP id
 586e51a60fabf-2e9bf538bb7mr5028409fac.30.1749137714833; Thu, 05 Jun 2025
 08:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: zepta <z3ptaa@gmail.com>
Date: Thu, 5 Jun 2025 17:35:04 +0200
X-Gm-Features: AX0GCFv-tBJYCJ57PVVEk1Gj_iimZFZ_kgw0_MBmdJ1CpQYsm9ermDD4fvj2Z3g
Message-ID: <CAPBS6KpGThpPpzLfJDJxQc_Njv+yEY2z7XFo6zX5EFKG8O-1Tg@mail.gmail.com>
Subject: Stack overflow uefi get variable
To: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi!

I recently discovered a stack overflow in a Bluetooth driver. Here is
the commit https://github.com/torvalds/linux/commit/3aa1dc3c9060e335e82e9c182bf3d1db29220b1b
fixing the issue.

You could exploit this vulnerability:
With physical access, one could modify the nvram values to exploit the
stack overflow.

I also found in an email thread that says the OEM does not need to
create this uefi
variable(https://patches.linaro.org/project/linux-bluetooth/patch/20240626092801.2343844-1-kiran.k@intel.com/).
This bypasses any runtime variable lock that the firmware might have.
Then user can set/create the variable from the OS and overflow the
stack in the kernel.

I was told that this might be outside the Linux threat model because
the general consensus is that we trust the data coming from the
firmware. In this case, we can set the variable from both outside
and inside. Is this a security issue on Linux end?

/ Oliver

