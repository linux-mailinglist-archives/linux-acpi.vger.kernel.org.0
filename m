Return-Path: <linux-acpi+bounces-17311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4E7BA0702
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 17:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92EA1BC62A3
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD433074AC;
	Thu, 25 Sep 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccMA+hRF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0A303C9B;
	Thu, 25 Sep 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815301; cv=none; b=F3CsdZ0T9gkTMUgNV9AOrhn52ePrehiXv75RC0mOxBhS5GcvBlDFmsIPnR+CwH9RXnt3dzeywE/XTzc1EY284N2aqso9P5jtH0k0xUuas9Szt/bsbVPxHMUiNt8RcXkzzubUXgDtuPghC8V4gmTn7CINatlw3NsujcY529GlQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815301; c=relaxed/simple;
	bh=alFlVNCO0SCwIXUwvG00WGutBDz+AMdOtU1RcQG9/6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IS9+ZoH1IuuH8kmhVnWNllS7CKJJqBo95Wpmzmj8ULCdKFOyrGv8m0PnY/EnxfVe6m+w+GRuwDMXohGZeuR0+qT2EJyjXH2X0f5uA8qKtGqGg5M7J8mPc8DPIX4PYcKK0tPLh0aQi51321vTc3uG8APzXC6dUm8MeoNi1YsHpMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccMA+hRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D92C4CEF0;
	Thu, 25 Sep 2025 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758815301;
	bh=alFlVNCO0SCwIXUwvG00WGutBDz+AMdOtU1RcQG9/6A=;
	h=From:To:Cc:Subject:Date:From;
	b=ccMA+hRFcBBLylc6P4ZJ9RDUmgw/iFi0iYr8EL056ivG1geb8sZWlq9+L/+JeCf/4
	 IJYd+9JBw9cIEyrFuX6OpI+qslDSvbMzffoUr9wyPcm88bryp7uHJEo3+ungb20ow7
	 9oQrJ39NEFAy2LTn0BzpmGgKHCxrmZWG3P2DkhPy1So+6D9BlFXrl4MrAR0AQivuuv
	 U9HvgdsrG+HDZT48KPcydWx0INp7CNoCC+jw7xxxzg8Ct9hCzuZsA7iJe6/BXKj6CU
	 lL8m2o1XlvsgFfQwutW37qmoC2xx9nS63f+BzNgOFFvUv5QkQ4YSqpJxJ6qBJB7JZj
	 H74Vl9N6nHLmA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Prashanth Prakash <pprakash@codeaurora.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH v1 0/4] cpufreq: Fixes and cleanups related to CPUFREQ_ETERNAL
Date: Thu, 25 Sep 2025 17:42:16 +0200
Message-ID: <8605612.T7Z3S40VBb@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

The first patch in this series is meant to address the failure discussed in

https://lore.kernel.org/linux-pm/20250922125929.453444-1-shawnguo2@yeah.net/

but in a different way than proposed by Shawn.

The second one is a CPPC cpufreq driver fix preventing it from using an
overly large transition delay in the cases when that delay cannot be
obtained from the platform firmware.

Patch [3/4] makes CPPC use a specific symbol instead of CPUFREQ_ETERNAL for
signaling error conditions while attempting to retrieve a transition latency
value from the platform firmware.

The last patch removes CPUFREQ_ETERNAL (which has no users any more) from
cpufreq, including all references to it in cpufreq documentation.

Thanks!




