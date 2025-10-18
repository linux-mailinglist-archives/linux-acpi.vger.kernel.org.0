Return-Path: <linux-acpi+bounces-17937-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28908BECF88
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 14:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 675D14E3A20
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55892C08BC;
	Sat, 18 Oct 2025 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsGbIMQE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ED42882A9;
	Sat, 18 Oct 2025 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760790311; cv=none; b=ZqCBF0ia8+O7UMhP5G6NR2GN6o3+BLfTNx8uK+vvDClsOytsTvn8aHIStngAz1HfnVti1MqHXa+xjpZ99PY3a+QUfm1VYo4FApp2E3J5kEaIVtc1F+sNYenDSfs5SeK8xXFTbMt0xXf1A7G65XljjSY64mswZcaReccFVWp+Kyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760790311; c=relaxed/simple;
	bh=Yjt/mwGqTYgaSp3IkVe2eq2mxkadGDI7jkjoPokj5uI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KM0BdfHYhkPXwfdJc9WxSQau0DhmIFmnm9L3U0IH8MvDLn0Vc2cJq2daloV3SPif5xlRJQvU9VJbHvFv1qqDoBVBT0O2SPXPQ2f5yjkP3ySqwC3jNR2pAJJYZ8OpPC2BcnLH7HFSrNEC0+GR9G4NrR9jK4zDoIj8554sQFHEdX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsGbIMQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B1CC4CEFE;
	Sat, 18 Oct 2025 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760790310;
	bh=Yjt/mwGqTYgaSp3IkVe2eq2mxkadGDI7jkjoPokj5uI=;
	h=From:To:Cc:Subject:Date:From;
	b=lsGbIMQEoCtuZrArvWM0lnBi49nL6rgT7KhrRXyyFnk8v8BcdtE/opQ/jKr08u0Sz
	 rm6hkW5KYdqT4l8rsqwg0qa9rprwO4IQXqkJHAoODghp++a81z2e5Dig8tTq0mgsqB
	 dMMv+hJHTJorB+QNpHfG5OOeDZ2eOVjsXszbea9Jqq7YFte0VhnCGKz9e0xTcY2TOd
	 PkGaR19x619R66fYRdi0kXOVNXPIS0DAJAsTCPlINoZdpN/PKk8mWq/Z0w34llg6aU
	 c9BpALMBcfYxu02UZHq/g3nnuqHzH6Q/bW+beroO4pNiDjIRkG9cNuqPxfFxgxbc4C
	 9s0ChOjtt+fKA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 0/2] ACPI: TAD: Use auto-cleanup macros for runtime PM
Date: Sat, 18 Oct 2025 14:22:06 +0200
Message-ID: <8599731.T7Z3S40VBb@rafael.j.wysocki>
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

This supersedes

https://lore.kernel.org/linux-pm/3925484.kQq0lBPeGt@rafael.j.wysocki/

the first patch of which proved to be controversial (quite as expected), so it
has been dropped and the patch that was the second one previously is [1/2] now,
and it has not been changed.

Patch [2/2] (previously [3/3]) has been updated to use the full ACQUIRE()/
ACQUIRE_ERR() syntax.

Thanks!




