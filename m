Return-Path: <linux-acpi+bounces-8303-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA0979826
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 20:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D861C20E85
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 18:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D96A1CA6B7;
	Sun, 15 Sep 2024 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUsCy9Kr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960801CA6AD;
	Sun, 15 Sep 2024 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425555; cv=none; b=REAO5uPwPcqp7R6aoriSp/2ho2DjikRBNgp4ZC7tnjgkdObjYVOAVJsXzZqr54iRSmXo9jJ2Os11AUewKyMeNIEPPoqWQQA7umh6RG2ognNQ4t+R0Yp2E50++SknGJJKuDxt90CznXvnv+zsaFChrV7Ixok9dz+49YjdDw5McEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425555; c=relaxed/simple;
	bh=dB+ck7mCzPqh9iQGEzxZtqVXuGGnstUJLE6atS57J9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6zCF1RtEgGJXI8ueKxPYp3acc6fxiJUYwlU/FmCGUXuY8ULWS6RORng5Y9gEInjDemUIA3TY41nvYcxW5FHv8BHWrrAzOfx2YpmRLPKX1+ot/57/iWsLi/AXSAMe9gruYA29HzMu0Vi7XAmM00jizgJTRT2yz27t5y5n6/ro20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUsCy9Kr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3787ddbd5a2so2240642f8f.0;
        Sun, 15 Sep 2024 11:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726425552; x=1727030352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DezwI2dAdBPfxx7uR9AzXDV/o4jNlzsYm/PAE+1Iick=;
        b=QUsCy9Krfuywk6o1lyy+6gFKVDIhhZgw05yhvi3lRz+wvBLSqcgxIPWvJo3Adv4jj0
         +ev760w1i0dVls+F7SMlLnE/WbgEIIqU1G5yuQqNNNN9W5UoaR+0nconoXJk6a17QYdO
         E9/37jHK1ZAk8w01+vLGdGGTXEdiQ4CSpxKXAAD3lh+LJdMC8u/2OBn4XkgxcpPOVbM7
         y06NwgbpM2m2Uy8vA0GDiXiDYuIepzjRc2ha9Nn9hlyUxe20NOHRQXbQgTXf27xnnYZH
         4iSC+PgBhAXFo0YOAERadaDehNK6fFShjhNvcrnkEJwiiux5SQkqApu9hKJX37BS3I9Y
         g3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726425552; x=1727030352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DezwI2dAdBPfxx7uR9AzXDV/o4jNlzsYm/PAE+1Iick=;
        b=IcyXmRZf9HG2ivbXByUFDrGKOMQixjBdTkguBE+VfPDhwgMoS5NJcgJtALFkO7590/
         +MLYkM3vFb7XYmlBY4gO3VI8c/4lJ+qpA/PBWMGnhcowyXMAi+qv/LbD/7YtKeUDjloU
         EA+QzIyPbuqX4f8V/ArkZ86XjFU5X2XotLUYGERVXO982Vm5HdGHsVlIh/L6n6arj72n
         9sIbFoTglFgOilFl5+RtTWiBp0GpUO8Awr2+VUV+qN//y2wxjAlXScRp6s0nHPI30Uun
         zyjAuNkNlGenSG4IeNS7FMJQUT8pjm2BfBzmIj5e2uYWR5FVp8/ikIYAlZyFMJLtHmz1
         t9IA==
X-Forwarded-Encrypted: i=1; AJvYcCV5lxIBMPWjbaudCO9oEaSyxcwkV712duaaF9929WOOObbjtTf29K2O2tTDwvsOJQubJyxByFrLm44o@vger.kernel.org, AJvYcCXuCveBS/g3AYkft5E1Lubk+s3uJwBfQbkRsio6mMHkIGRsMqsdxMN0u25ftoM5IMAqJQfI0hxLcpP0Yvze@vger.kernel.org
X-Gm-Message-State: AOJu0YwbNDpdCUJAk+FY8MgsE7R5t5UtgRl+u1RM7chCeXHVhuoi7Ysf
	stXIQyrcJ4mUUo58mzeCge9sZyjdC5YS9kMAxa6TIDXqvvAyLOzxlzX4S4T7
X-Google-Smtp-Source: AGHT+IF5U0HHjNRcC9kN3bE+yuznkwZkE2b8wB6ECzpnSb0eTb3lk5mRKU4inyyvuCq03us7KkuDzg==
X-Received: by 2002:a5d:4806:0:b0:36d:2984:ef6b with SMTP id ffacd0b85a97d-378c2cfea88mr6860563f8f.11.1726425551651;
        Sun, 15 Sep 2024 11:39:11 -0700 (PDT)
Received: from qamajeed.Home ([39.45.198.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f2001sm5162357f8f.48.2024.09.15.11.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:39:11 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH 04/10] ACPI: pci_link: Use strscpy instead of strcpy.
Date: Sun, 15 Sep 2024 23:38:16 +0500
Message-ID: <20240915183822.34588-4-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240915183822.34588-1-qasim.majeed20@gmail.com>
References: <20240915183822.34588-1-qasim.majeed20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() in the ACPI pci_link driver.

strcpy() has been deprecated because it is generally unsafe.
Eliminating it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/pci_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index aa1038b8aec4..e68942664b61 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -714,8 +714,8 @@ static int acpi_pci_link_add(struct acpi_device *device,
 		return -ENOMEM;
 
 	link->device = device;
-	strcpy(acpi_device_name(device), ACPI_PCI_LINK_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_PCI_LINK_CLASS);
+	strscpy(acpi_device_name(device), ACPI_PCI_LINK_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_PCI_LINK_CLASS);
 	device->driver_data = link;
 
 	mutex_lock(&acpi_link_lock);
-- 
2.43.0


