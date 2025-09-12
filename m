Return-Path: <linux-acpi+bounces-16780-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5D7B55770
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73766AA29F5
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D5352096;
	Fri, 12 Sep 2025 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYNRhEJV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0778F35206B;
	Fri, 12 Sep 2025 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707629; cv=none; b=o3mGQqra+Gt3Yxwtr7UPjOIQignlIp296La7qAFo7Lom9+iLaOiKlcAwvdecMVbTf2Mvd7pXYWEz4kDqCAePL1Lo9T8EQRmL2q5yeQ8e+NaYB4eMNcWwpu72c60EYpcoNzJsEG2lIflDJHv0UgrrZHbjFSNo8Tap2NFdspjqWH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707629; c=relaxed/simple;
	bh=fbTNnGgN+onKnA0D4m3z/cRjH2Q1tRKdn8hJBDJcsB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=np3LqcTpPo9fCzThZmLjMAfR6sb5BpQEADdlFi+5fGPRek+/7hMj34BNZmUd0LdCEipsDqe5jFVsdDu6CbwlQylKyhiu1+Rm9mQfMd7dDT0byvNDEItz+O3adSapA+Ww6Wy7xyR0wrV9cCdAINdojOjNcO2EZTV8J+Pn8eC/jqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYNRhEJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20086C4CEF1;
	Fri, 12 Sep 2025 20:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707628;
	bh=fbTNnGgN+onKnA0D4m3z/cRjH2Q1tRKdn8hJBDJcsB0=;
	h=From:To:Cc:Subject:Date:From;
	b=tYNRhEJViHdODeDcW/oOH+2yjFHZKuHJANbXyV0g+8+7GA68yJzbmxviyPIPQtNDl
	 hMXWif17D2SvyuMBq98UZ0+tjRoTxLcnAar+7rOflX+3W5/q7fi3aT9dQqfLGHmpN/
	 Mz9J4lL1stIeM9Bu8IJcEld3X9ANEKWIAjO+neLY4S0MEyoGKWRU438/SoPncDpgpc
	 98Tq+lRRAukpkOH6UpAZYpCG9hBSkJUq6EKqZOuAAHp4+GpmLLE2t8nN4N6D0Q2MSt
	 U8ZD80zMiHG3ZdHcynOu2t7HKrTO+XzpwcjXcfz7FRjQfTCAOG2SxbhhDUkyt04FDG
	 vLtavTITFkHHw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 00/16] ACPICA: ACPICA 20250807
Date: Fri, 12 Sep 2025 21:51:23 +0200
Message-ID: <2021361.PYKUYFuaPT@rafael.j.wysocki>
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

This series of patches represents upstream ACPICA changes made between
the 20250404 release and the 20250807 release that have not been included
into the Linux source code yet, and some upstream ACPICA changes made after
the 20250807 release.

It contains the following material:

Ahmed Salem (4):
      ACPICA: Apply ACPI_NONSTRING
      ACPICA: iASL: Fix printing CDAT table header
      ACPICA: acpidump: drop ACPI_NONSTRING attribute from file_name
      ACPICA: Debugger: drop ACPI_NONSTRING attribute from name_seg

Davidlohr Bueso (1):
      ACPICA: CEDT: Add Back-Invalidate restriction to CXL Window

Dmitry Antipov (1):
      ACPICA: Fix largest possible resource descriptor index

Hans de Goede (1):
      ACPICA: dispatcher: Use acpi_ds_clear_operands() in acpi_ds_call_control_method()

Huacai Chen (1):
      ACPICA: Allow to skip Global Lock initialization

Kaushlendra Kumar (1):
      ACPICA: acpidump: fix return values in ap_is_valid_checksum()

Saket Dumbre (4):
      ACPICA: Update dsmethod.c to get rid of unused variable warning
      ACPICA: Print error messages for too few or too many arguments
      ACPICA: Update version to 20250807
      ACPICA: ACPI_TYPE_ANY does not include the package type

Zhe Qiao (3):
      ACPICA: Modify variable definition position
      ACPICA: Remove redundant "#ifdef" definitions
      ACPICA: Change the compilation conditions

Thanks!




