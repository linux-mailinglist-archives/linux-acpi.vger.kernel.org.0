Return-Path: <linux-acpi+bounces-15677-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102CCB2645F
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 13:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175EA5A7596
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901532BE020;
	Thu, 14 Aug 2025 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l76vktzh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FBF41A8F;
	Thu, 14 Aug 2025 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171286; cv=none; b=Mg7A99yoUt9jyDnLVv8GVsUfB2zL0YK1R7+EQDwKkbsuFzUKoUnmY+GLmTjwOiPsbSjNLNEGA0tZEQlB1MtIJnTvzOhPx+Wb6rilLrMVZTvEMryQoV905GfcY6P0TosgQ6Yc8DhR7uVouyHGngIMb1bssfAZ8UZM9TdH8h4UHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171286; c=relaxed/simple;
	bh=Zuk+VGhg6j5wK1OB9dS8TGsA6Z+8A+u3suS/2dnnabE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aFzsAPZBq3bTPEdGyxiDKwkhhBN4ezAVeGeavwtTwZxCZecK5IOGUtKFBGt5LDUj8Ogl/4BR3WWd8v6uw0LBEjvPp26Li7OIPVwh3b/IfFJj25EgGmFicafl9C2Zt4MYy3sYIr+8J5o++aGTgIc2IPSksX9jzfJb6bUP0fvTjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l76vktzh; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-74381e0a227so606530a34.0;
        Thu, 14 Aug 2025 04:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755171284; x=1755776084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KfsQ0qqhk7rtPTAMLbJo5EZqlICp1s4TcMgY/WUahN0=;
        b=l76vktzhZWPa8j+weL32foWTGKaW93k4wrGxgC3aWRCNqC0UcrTgJdViEMkQ4FRu7C
         SDWbesyS/SJGkOLWeieuxfeV0rjN1zznLHYJqv+d9DYytzevRImY5QAIep6uninNSvob
         PbMlmcNh1nfC1W2USqJYQ8YokQpp1KDEz5V5MsscvYiTsYV2hEabdnzMAz2w8fDEI00f
         p5V/5N2ebNAtroQMTG+ucRTwd1s3ykPuG/vdhWshfe1pIx3/6rm+8kKS67ZnzFW8HEE/
         8Pdg38gfUqmb8cunIw/CJap+iKs5NQ6cTlL+6ZJHtETdNnWp+1NHsDKWdIEBzR5/gzQ7
         ajxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755171284; x=1755776084;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfsQ0qqhk7rtPTAMLbJo5EZqlICp1s4TcMgY/WUahN0=;
        b=oLPfEwg6ZsxE5jUkrnkkdf+vD0x8hG+iWPuD23umeErv/DPYPVN0O8qwDHgHSDaXd+
         1XjyojNY3/FDxMnbm9qujOeQlUw2fgh1JdcacGU7TPdgt2IlHTdrMqyeXCbHH0jt+b0M
         UOoE8+rupZXT4HZVbUzKYkfLDe0D+hei6hul6t3trsqDmatemGSNJJDLN8YCd0WU5wZW
         4BJIgGogeEjZ+hyQ6+zFfk+zMhSJl4fswiR4AJXKPY6Utngl1WqLIs+AYjgCvX/z7tlD
         8c/vWwzZ8gxANJw47ttiaJ0GagImNRY3itHtpaKMvEeJPgalMq9wpUkODN2xi7WGFeBX
         539w==
X-Forwarded-Encrypted: i=1; AJvYcCVQtIXkfh985Jt0QzHNE9729jHf0oNgbPZeHbNI0QwjJO8hd9WLZuR8wqzjWFm0yP4McxiCGnBtzgA=@vger.kernel.org, AJvYcCXnydKWTEy4Tg2okDaAN5d+oR4FyFol/EwqxISgF/BQp0kZwp6PPdUq3imBO+F7NTJOOxgVr+KmqRJHiQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgmotqAzT7KdwZCaIKVTZtVtTLeeRzdILsle8kIcVlDkVr7xAA
	yDTKOFjj6+WCOQAj+ateWFGAYoVWYAil6UeZpgcp9aK7LPQQG0k5e5LWJjEDuWJjogMMPAdE2E5
	52ck07XDF9wbX9TyXYoiImNE3GldEG46qOwuk
X-Gm-Gg: ASbGnct7bC2QszF7vF06Agr4YBSOcxIP7HdO+5WlKk9+yvI5uq8f3ZK3gaDtPx+fxJp
	YVuBeTxaq3TZa6/2KkfVxyFpe/f8YjUhLHr5Rcvav4HEUIiipFbB6q03jTYdmSZ9D+xjOORfM14
	h/RGUkgIUXs8s7Q36NQwhj3fqU5v9tPaHnAhezobq3hC2u+LywiRdQUtu7ogFPqWotTyAyHJVhc
	c5J
X-Google-Smtp-Source: AGHT+IFoou5bSu/kqDLdzefLDe0WLJaufqCS9rAF/VRLOcfCgnPo245UHo+Js3kcXq6dc//GcucSxxgTqPnwfAXzSZM=
X-Received: by 2002:a05:6830:3497:b0:727:3439:5bdf with SMTP id
 46e09a7af769-74382bc3f86mr1518448a34.13.1755171284124; Thu, 14 Aug 2025
 04:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Date: Thu, 14 Aug 2025 13:34:31 +0200
X-Gm-Features: Ac12FXytc0dymczB_6o7akUKrXNMtwU4g0NYyt99SuhFWDhS5SSpjpVawz5w29Q
Message-ID: <CAJZ5v0hdFatBoM-o3s_-+Q+529npq8FNo36pESFQrBGqZJdm=w@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.17-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.17-rc2

with top-most commit 40f2f1aa62578547e2977e8c0516048e0b71018c

 Merge branches 'acpi-ec' and 'acpi-processor'

on top of commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585

 Linux 6.17-rc1

to receive ACPI fixes for 6.17-rc2.

These restore corner case behavior of the EC driver related to the
handling of defective ACPI tables and fix a recent regression in the
ACPI processor driver:

 - Prevent the ACPI EC driver from ignoring ECDT information in the
   cases when the ID string in the ECDT is invalid, but not empty, to
   fix touchpad detection on ThinkBook 14 G7 IML (Armin Wolf).

 - Rearrange checks in acpi_processor_ppc_init() to restore the handling
   of frequency QoS requests related to _PPC limits inadvertently broken
   by a recent update (Rafael Wysocki).

Thanks!


---------------

Armin Wolf (1):
      ACPI: EC: Relax sanity check of the ECDT ID string

Rafael J. Wysocki (1):
      ACPI: processor: perflib: Move problematic pr->performance check

---------------

 drivers/acpi/ec.c                | 10 +++++++---
 drivers/acpi/processor_perflib.c |  5 ++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

