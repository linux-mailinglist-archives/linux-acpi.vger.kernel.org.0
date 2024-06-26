Return-Path: <linux-acpi+bounces-6626-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D738A9181FE
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 15:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE14C1C21FD7
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDA9187551;
	Wed, 26 Jun 2024 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8i/fs89"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC283181326
	for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407395; cv=none; b=gZgLJ4k8FKidMLEY6pPWk1RheNToR/4SILEicwFOoHftnM68zIC75galF+qlR6ees0d25RyQ02qUwvi5FwLE3kRmP5cv6hZE1O5SnFSERKUHzWbWcdTq4tfrE4qBb7gJLDbPI6Ea/clYxjpDTUrocgvnxGLS2njqt8pz1meqhbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407395; c=relaxed/simple;
	bh=B7Gb4HTLPUmQ22WtKLtp85obb95gyxRXGj8X7+DC6Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVJLXzYU3zw+sphb0RuMHiARS4bglCCGvGk6nSi8OO0ETHWHVtotFl5zYkEEszWDUV4i/bli9sRTEHXBgcl8fM39Pi3eub0TDLXTWDqZt7ByAZm5YfY++cgCv3N9RlivoIxyMb/ANLwJQk+bsSWCZsNEVk+RSgDINF4VO8IyD0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8i/fs89; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f6fabe9da3so54488125ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 06:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407393; x=1720012193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IkQks3ngJS3Kpk/TsPkl42GZ04VpzN+Wf+d01BUmFbA=;
        b=O8i/fs89IXiEx20OnWH9YFPdoxSRGSSaNlLsMNo9eBFOzIat4eGHt/k0DkrzJq97tP
         rQ184AVWtDujvnSKJC3iu4PJ9uvKqrcDe/WwBiw4WbbXq+ADaS/vQ4WtVirDMkxbcp/o
         ebxv/sIm8zcUzRl71eLV7NkxilZqnCktNLs5PQ+9mQytYdiF61Wc1GP35QlpXBkEumK1
         FPbRomG0CTtjvJet0ciH/dM5wEXaxrR3lEzny6TRtQemO/94bSLCY+PAKRnkA2Ctzf/Q
         VrzzEQ+n0oPtNLsIImI0iXHYkh3JR8OT+sxyNX55ZvA/I+tLXBx4gG9v+WgeLskJ1VXJ
         0GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407393; x=1720012193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkQks3ngJS3Kpk/TsPkl42GZ04VpzN+Wf+d01BUmFbA=;
        b=ByuDPrncmmk1OAaUvlUxAKOgk1J14M6qYEHZPdQ19kumDeuXL5n1ZVZoSEss+gKvt2
         uUVULWXVw6CCgg86huRvQfv3u5WoM+xT+s9qcYJvqg2R7Ju8NrN9WjQULr9G37zDfK8F
         jBJpHBMV3u4V3Pfo9sYJckxcvbc+db0+GmY+WqrzV6YdEAmrT+fTKJtg3HlgeMJmY6kR
         JxX0wBQTcPbcdVjbE/uYy2y1yWRYHPPb7WSE+YQzXQDw2SS+4oDWkRd6h2fH0IuyxPBW
         eInInfTIK9XuihMxIRwKtOJ5y6mtkhyQH+YFxL7guUADCBFgcAn6XzaBZgVS/JeNVzmz
         IW9A==
X-Gm-Message-State: AOJu0YyqT4bFhaFrvCbbM0exXNysowKd0zIhb/PJg+JzzPaSwixf1gkg
	UIEdb74C/PQvTtXgy2qm6mwM8zydm5d1/QDvOgyBorVuXwR3rnsILh8R7A==
X-Google-Smtp-Source: AGHT+IEcvdF+MJYdVLKtXPr0VUoPp/dH7wZh5ogQuEvCoAz8wy/O4WfjiIxuZA4JpbaVSdjSrIzxPQ==
X-Received: by 2002:a17:902:e74d:b0:1f6:fcd9:5b86 with SMTP id d9443c01a7336-1fa23bdab14mr113075265ad.12.1719407392774;
        Wed, 26 Jun 2024 06:09:52 -0700 (PDT)
Received: from localhost.localdomain.oslab.amer.dell.com ([139.167.223.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb3f1esm99049695ad.265.2024.06.26.06.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:09:52 -0700 (PDT)
From: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Subject: [PATCH v2 0/2] ACPI: Replace Ternary Operations with min()/max() Macros
Date: Wed, 26 Jun 2024 09:09:39 -0400
Message-ID: <20240626130941.1527127-1-prabhakar.pujeri@gmail.com>
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

Changes in v2:
 - fix: replace  max() to umax() for unsigned integer 

Prabhakar Pujeri (2):
  ACPI: CPPC: Replace ternary operator with max() in cppc_find_dmi_mhz
  ACPI: PM: Use max() for clearer D3 state selection in
    acpi_dev_pm_get_state

 drivers/acpi/cppc_acpi.c | 2 +-
 drivers/acpi/device_pm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.45.2


