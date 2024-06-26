Return-Path: <linux-acpi+bounces-6618-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFC3917F55
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 13:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C18A2841AF
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 11:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D187E13AD11;
	Wed, 26 Jun 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK++Mfvs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A7217C7D0
	for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400508; cv=none; b=goIoecDF1xHR+chDvxBbVlKierXo9kUNYmOmJixnkYAG2UaYgYcXAbvDaLBpC2TXeRd25az3PkxFJQtTPLxmZctDr1nfZtykPIlCj9Js5bPdF4gXzMK42qzpNFjQuE0yI8Wo2XE+2vaSJbizqXCeBINGBTGoRHdgp8lTHAHOj/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400508; c=relaxed/simple;
	bh=GuXpVZXf0z3Vh+40cwSc11whSz6lmdsGZ24kfd+aFa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TVj7dsgEq+pPMUs5sM/RoG3b+9qNdMpyk84mKukbHe1U9fGECAxNZoUsnMGceFV2nRDvamuwDc7xnknehRNXX2NK7p2ag8BqNFuJ+j1laDLEcD9bGVX1+kjcowhhjKS8qSBHi8yrEHJfyquQ/brCinaeX7hkfuxZTmJpIZI9scc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK++Mfvs; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-378d954e505so576135ab.1
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 04:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719400506; x=1720005306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yIiGmUTqJBQrf0xIqKlfYuVeC3Xz+10PJt/GEJuLxD4=;
        b=aK++MfvsQeo+92o1AjPFN1JKw1D8Zs+YbuwBLb3S6r41bFMVuNpBDBsz8mhRgY++3s
         vbCYC7WoT6tV5eoxNdgmesipw3sL1eu3ga/odOkBhAd6T9ttSUcB9Rk5PAmaz1vGVek1
         +HhvZHEVxTzcpwIUz0388tgJ+GOBcnWAox0A/9OYtQxUdu2y/FmQFN1tOOe1aaGP/Lu4
         EojQjWtQEhbJtDSrKrYMMLLFT8j0MwQcpZTymdTVE3YoK51uWX2/aVZnzM9Nl3YpyAq8
         fcEotO/izsq5PHyfQi/jnLZzLb1m7F0LfQ2bEtbtoHSCQTcrz5k2dvaYnz5NzYlef6Jh
         hcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719400506; x=1720005306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIiGmUTqJBQrf0xIqKlfYuVeC3Xz+10PJt/GEJuLxD4=;
        b=qwGBjf83pJqHiEUH22MDWzpI36MhcdiAj5L2JsKXJ0v6KUOwczui3oWAeTq5Yoryqb
         ZoqxAoB4Wfs0YrmWJ9yGRRCpdbYeguEjQEFkWBIXpxwClYayOEhNIt0fK0V+sGlfjAsS
         h1mf0OZghqZpoSTtuNX1ZXm5B+k6ytpM9KMwvoaJufJpuv5EQzmI3AbOIEOkL5aC6BI0
         haERkH/G3njg1IvNkxeNE6vTjXdiwpQQL4U6RAHsF88X7m4I1rDoXeCQOKgUQDH9/LsH
         EGrJTpFjnOylZ+fdQMBf2sLubOTKQhIOffpqJaRNRDZqMA40bSkJzLZs6znYqhH7XS/Z
         3Hfw==
X-Gm-Message-State: AOJu0YyQQ+hGL1dOfrvjU9FeQiKj4Pi3BsWLFqNQbtqWP2rxTqJE5MrN
	gXC2Um6JmsQeFki6mGygllJKUqDVWFZK2MGTmtJoVLWljGsl5ZEnaVXPoA==
X-Google-Smtp-Source: AGHT+IEq4vdT3MClXXEIbrbXNDuWcF9e3OxMJGWijz8YKdt84u3fLMZ9H6LF6naenupVi7AA2/36VA==
X-Received: by 2002:a05:6e02:214c:b0:376:1cf6:6be5 with SMTP id e9e14a558f8ab-3763f6cafbbmr136217095ab.21.1719400506275;
        Wed, 26 Jun 2024 04:15:06 -0700 (PDT)
Received: from localhost.localdomain.oslab.amer.dell.com ([139.167.223.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-71893794615sm6368185a12.88.2024.06.26.04.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 04:15:06 -0700 (PDT)
From: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Subject: [PATCH 0/2] ACPI: Replace Ternary Operations with min()/max() Macros
Date: Wed, 26 Jun 2024 07:14:44 -0400
Message-ID: <20240626111446.1445111-1-prabhakar.pujeri@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch series, generated using Coccinelle, aims to improve code 
readability and maintainability by replacing ternary operations with the min()
 and max() macros where applicable in the ACPI subsystem.

The patches have been compiled and tested on an x86_64 system.


Prabhakar Pujeri (2):
  ACPI: CPPC: Replace ternary operator with max() in cppc_find_dmi_mhz
  ACPI: PM: Use max() for clearer D3 state selection in
    acpi_dev_pm_get_state

 drivers/acpi/cppc_acpi.c | 2 +-
 drivers/acpi/device_pm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.45.2


