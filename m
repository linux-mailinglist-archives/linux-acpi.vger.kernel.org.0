Return-Path: <linux-acpi+bounces-17119-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB868B87074
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 23:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CC216F549
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 21:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7293A2F9C39;
	Thu, 18 Sep 2025 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzU8NAzO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FF32D594D;
	Thu, 18 Sep 2025 21:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229859; cv=none; b=bpmtY0j2sHwTT4/2lifuZHPhil8T13HFjXVg/M97RFIzvZpVEbqz+3319fsg9gNXraSh/ITVvuu7Nw67KyQ+FQXW3tfpw1aQaGc6pUjD8UCLSP/5qn+hhRMpsMDXov5lSkxSRHn9h1qWFKWlKhjwRsS6E5rufP2de4spXHYtdp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229859; c=relaxed/simple;
	bh=tUpl+Aflsi7oOnWRgUhIJJTohUNGrnx1/nd3kTMjtSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S6PN7o5eOb9LCjlxzctXnE0aNTev38HHcm2lOyCeeDpHgJtSrIwuosz79B7/mSpUVfF2fkCkMxmZRdfagFYJ5/Tfwzt5gujk/MqEndd+tYdq6Hv8xgVke8QngU6un2WSV3ihTdVEj6EHgRLTmNMEwaimi7hXvbI84mOfzPmpv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzU8NAzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7B3C4CEF0;
	Thu, 18 Sep 2025 21:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758229858;
	bh=tUpl+Aflsi7oOnWRgUhIJJTohUNGrnx1/nd3kTMjtSw=;
	h=From:To:Cc:Subject:Date:From;
	b=OzU8NAzOzy5wvDuipYo4thmodtRan5i2uOtKbTwV9kTZfU+9WlR+nLWiEicAIyGai
	 yu45ebToE7ynhdpt4gSBm86MXMmNNEEjruI1OcScKDibqQl9iNR9GbQn22A2XrKPnQ
	 du89HLhKQA9VuQyoka6aW5iry/Vhd6pUZ+BrOJMexbZ4VL86w8R+unAWGfpDoD1ZF5
	 WlHBzxArfVfiQZlF2r9RmMqNBgCgmlHIwNeD/1anbu1iWoZ+E1YdE5UqMhFqmcsFxy
	 KWiqP61fPTXSQl5evYo9rARJed1cRkCq+tRHds9Rz89FGgeSvS/vXYhL7MgSwAYA7I
	 lGU8/5llCLyKg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Huisong Li <lihuisong@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Subject: [PATCH v1 0/2] ACPI: processor: idle: Fix and cleanup
Date: Thu, 18 Sep 2025 23:07:18 +0200
Message-ID: <5926523.DvuYhMxLoT@rafael.j.wysocki>
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

One of the recent changes forgot to update a cpuidle driver check in the
ACPI processor driver, so fix this (first patch).

In addition, redefine two functions whose return values are ignored as
void (second patch).

Thanks!




