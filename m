Return-Path: <linux-acpi+bounces-17340-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1A5BA35D6
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 12:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BF61C050B7
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18552F5A32;
	Fri, 26 Sep 2025 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJ4CjbLm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A662F3C18;
	Fri, 26 Sep 2025 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882751; cv=none; b=SolSXLUZ1vcoDBWDXknKBJkfwhuEDQmlcCW84eqfjFO/G72e6nI1UddifP/h9vuodvP3+VxbToIEXZPTTV7Euc7ZuHxw4uKFDOVvzEYln4drEn4kaJNGvMTexSDb+J/Rn4bR5xpAx1DCiTrXA0bok9IbGI6nBMdNY8SpGxfGAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882751; c=relaxed/simple;
	bh=Ept39HrAm04+87S86oqAzxPLU77FXrTemG5mmG5WCSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B2npR7r+zP/e6rBvCTr8q1ciqbGjOnxk6HLkH46n3BpIdC1c4F59hMVxM7h8L/HD6gjnxt6iG2MXiXFJE4CsoqKi9cuoZfEDnDWLK134f3xHEfnG9my72AYZvxdiLrQnk3kwVT+O3UrWdS9vZFi/awb1g8kaJYSVorgHH7CfJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJ4CjbLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA91BC4CEF7;
	Fri, 26 Sep 2025 10:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758882751;
	bh=Ept39HrAm04+87S86oqAzxPLU77FXrTemG5mmG5WCSw=;
	h=From:To:Cc:Subject:Date:From;
	b=oJ4CjbLmvPzUEP8tpFYgbnae+rhdErkvudQrAzdryMjqATv+wBi/aXwHSBXRF1t4L
	 6pSJ6AhxBF7if5sSTLrVB7E3oSg1vq+Nwsa9FA0uLpf+z03rnYdweO7eUKTIcsEMtx
	 r29ui0Wae/k2OSRJ1PIHHUOVA6mHi3YMnrKQe/UlwMElyc53iQE827H52tnbtPHtb2
	 kj+AspwcT01e/uA4dEgA7UViMmUHSPgsAgYqRO6aF/KsFf1MbKF2XKBwP4MQKK24wl
	 CJ0HTn3u8iglM7v7di4xI6qGwvInhozv2XnB36CAp13JOcD1RGQQxaTvVeOr7jVuDQ
	 HWw9dQYrGg7OA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH v3 0/4] cpufreq: Fixes and cleanups related to CPUFREQ_ETERNAL
Date: Fri, 26 Sep 2025 12:04:57 +0200
Message-ID: <5069803.31r3eYUQgx@rafael.j.wysocki>
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

This is an update of

https://lore.kernel.org/linux-pm/8605612.T7Z3S40VBb@rafael.j.wysocki/

The update is due because of some changes in the first patch (involving Rust)
and in the second patch (function rename).  It is v3 because a v2 of the
third patch was sent after the v1.

The original cover letter quoted below still applies:

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




