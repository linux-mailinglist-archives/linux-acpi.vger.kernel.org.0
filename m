Return-Path: <linux-acpi+bounces-6267-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E050E900999
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 17:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B0E285DF5
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EF7199398;
	Fri,  7 Jun 2024 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1pHSXOl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9864E199234;
	Fri,  7 Jun 2024 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775489; cv=none; b=YYB73SR1Rc1NGV3eea7zBPGXn2jUVVjHW6J3l3iNI8liLwBDp00UlVTeVYX6C1MtrPUmGJ7pWxBoZ9TmpPs++kobs4hkpWik3r1z3YMGsOYW/s/kIefRVtVxaUQxMXuQunKEq5mOe3K7QuB9OSG9m9fKV6y/+mT56SF2T2/KCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775489; c=relaxed/simple;
	bh=7CfxE2zPOgwLZD4RS4XeCHs98ZsI8QWw0qrMPFJk9XE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CbUoFr/fqqHRhLt2eN2zA3U9fZEZGW2Fv1jyfXUaRl03AddgLMcNFOTbjSLyaHQ9z7LFvjqVHls2pEGOA09nXZRbVpttLtg9fvTZz7aes3AePIBZiJQbntufvETfbB5qpFuGrOFybCoY0hUFf2kJzfldiEo2CynNDVG85MLQmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1pHSXOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2523EC32786;
	Fri,  7 Jun 2024 15:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717775489;
	bh=7CfxE2zPOgwLZD4RS4XeCHs98ZsI8QWw0qrMPFJk9XE=;
	h=From:Date:Subject:To:Cc:From;
	b=X1pHSXOlLvUovKKuGd+e73Yaep71DTi1SvHlNDPKiHZInEL0KZRDmQwM79UO8meFF
	 0D1WInJgXHeE/2XNqqkkQ/c/mrXr3NHouIS07oeX8Mmi+EnF1+tOnXetbtGoG1fHmw
	 HsTuCFDd4p+4cld3PpO6LxIFOe0NcbIaV/O/SFY9MVe9cjaUuJccsu+I47X2b7X0zi
	 V1dX9L0DI6gECrSVnlxgVmEe/+UOpIY5XGLNoOETSW13vOWbzuMq0icGckbyEa3FaI
	 n/sGDiRg8GWIV6uJM5a5U6GDMoKW8kpHzUnDYnfzw4zozMgzkw5QhiQTx7fMPclJU9
	 7ZEQLfmUaMjSA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b3364995b4so349430eaf.0;
        Fri, 07 Jun 2024 08:51:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWF1kXr8amUXkq/WTE3FFz7nVYE2St+HD8MtsiUSesQlhqLuzU7Ti+dX8VxY5plPR5+OV0tMwN/kGsT2wzXkJs+rQMDE86ihL/ALlZ8
X-Gm-Message-State: AOJu0Yz9yOdecrgeTfXsvTuY/GQdQ22+FEcr+E1J8cqvRcETtFWbiNv8
	7u97yJOg/E7Kacpz25xtaUvQwYBpbldXnFNqCna3ADsrqr6wWk2He0Fc08zgX2Hlv4vld7t5K6F
	Uuxd7r36GtcAEGal0dVQ9wGgvkq8=
X-Google-Smtp-Source: AGHT+IGX2GslOkgjanphDIumzam9KcMFNYxw4Ton5+xmCXwc3C7USV+vxgYtequ5ol/JVixRwey8RP6wDGklC1mM3dY=
X-Received: by 2002:a4a:ac08:0:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5baae73b688mr2760820eaf.1.1717775488041; Fri, 07 Jun 2024
 08:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 17:51:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hV6ruOVOO7GFP42vFYj70G=q=bhEOOG4vawyih5hiKFg@mail.gmail.com>
Message-ID: <CAJZ5v0hV6ruOVOO7GFP42vFYj70G=q=bhEOOG4vawyih5hiKFg@mail.gmail.com>
Subject: [CfP] LPC 2024: Power Management and Thermal Control Micro-Conference
To: Linux PM <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

A Power Management and Thermal Control session will be held during the
LPC this year, as it has been the case for a few years now, and it is
now open for topic submissions.

The Power Management and Thermal Control microconference is about all
things related to saving energy and managing heat. Among other things,
we care about thermal control infrastructure, CPU and device
power-management mechanisms, energy models, and power capping. In
particular, we are interested in improving and extending thermal
control support in the Linux kernel and utilizing energy-saving
features of modern hardware.

The general goal is to facilitate cross-framework and cross-platform
discussions that can help improve energy-awareness and thermal control
in Linux.

If you have a topic to discuss in this session (please note that the
topics should not be about work that has already been completed, as it
is the case for the LPC in general), please go to

https://lpc.events/login/?next=/event/18/abstracts/%23submit-abstract

and select "Power Management and Thermal Control MC" in the Track field.

Thank you!

