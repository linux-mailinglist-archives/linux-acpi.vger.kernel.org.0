Return-Path: <linux-acpi+bounces-9615-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78DB9CFF91
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2024 16:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683CF2813EB
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2024 15:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921363EA76;
	Sat, 16 Nov 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgQ+ciRU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D688BE8
	for <linux-acpi@vger.kernel.org>; Sat, 16 Nov 2024 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771619; cv=none; b=D1n7SdyrIGHSnRHSw4AOUGHoQ/DmpA/LM60IXIpEIgG55G7DlQ1Dd8uayuT3pl1g7cL2EEThnmRYrYs9zSh+DopEVUTxBx3Ox/moLgBIZ/8auTgzFk9GaX6uP9M3VzVeI2+tsv4L0fEryx3eMlPQsOYFVxMo3///0umZhXkR1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771619; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=UCEGTiKPDUUgiHE7ePhEq1kuqdU/qMRPXghBBLWsnBtiHXHV+nV6y1nlzKXA5MH4SeqEGTu2rj4YuZhhEOblzkLV+oaFQpa3LihANTv+RKTSGcsE/wCD5ummz55PLRyGMFBC4+DsAuR8HFD3QmrfxRybUlwWTJr4N2cLtAwLFv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgQ+ciRU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-72061bfec2dso485384b3a.2
        for <linux-acpi@vger.kernel.org>; Sat, 16 Nov 2024 07:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771617; x=1732376417; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=EgQ+ciRUZ1PoT/l6OplrDpjg/etVEk1kJnVwxm4MvyRYCr+tGAmYSKplFi7XVnVKmq
         sJzJDo1u4yDFur3HZhSm3/qWlxwSLvuHzZ+ztBBcKPX0svJdgnieSvPyQCdaaN+FeJOW
         SCNkGqZxnT7+FFMFSdVp6cnEs9iNY2U/JbsYfhMqGptHHJZ7GPtQQ1fvd5BT2ptNUFQs
         jmM1a7gEaBC3SBMerQ703f3FW/dUuRHBczRYMJsQuDaVROx4a1HDsmiR/MvDQUvwtXPu
         pCWeyVIOtA+UdBiBMzAyhJo4Pt6ERHA5ueB8M9LtOsON7gdrbcyXuFg0qIuKVQgtR0sR
         G8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771617; x=1732376417;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=cLrISoRPfY7kw/Pwc87FHo53FJf/lyaBlnd8Mhg685KSYSx0vn0C1woxmAjoo1Kneo
         4EaTJbE1vIYPB5HADZt98+y3glmAky32r96J2QmTbTICHSuEwPZ9jEOkyj+36hD6/pXg
         yuxNO9HYTaT8X7I9q6d2i8Ll3GsFDoHkEUQfLybtm9edawrktMIj60Ds2fqv3woN9Xvs
         RyLRXe8XP2OcX76QWqolDH6Je18UUr6qMYiWSk1ojP/H2Ga3WiZQfe6SbhtQK4Eh1L6T
         5ZrS6saTqD1fIrX+yt4+oIJqaPiMHIifkTWU3vS0IhLPfBOmfprJJKOiLmzLwjhCA//x
         pDrA==
X-Gm-Message-State: AOJu0YxNJDiNZOVsyGfAJbQCxZ0eTJr3S+HEpsckGkE58xoSl4zZm2Jt
	wwdj/LWM+9UMvdvJkoNARaTZmJgkgSSTh/dKlbKoFVBTX3RgHTDpG9Uo/Q==
X-Google-Smtp-Source: AGHT+IEQIzUpkYiCXUKdZpZEWL8A/9Akr8FXW8hl7hYDbil2KyrLoNGzZViqWtBA2xXCjXUmVzMeIA==
X-Received: by 2002:a05:6a00:1483:b0:71e:452:13dc with SMTP id d2e1a72fcca58-72476bb8a9bmr7941849b3a.13.1731771617270;
        Sat, 16 Nov 2024 07:40:17 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477200e52sm3309773b3a.180.2024.11.16.07.40.16
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:16 -0800 (PST)
From: "Van. HR" <carlonowell008@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <5b4a66292bb6a053c86b880c45ae664ee6443c9fc36ac6a48dd49149d39cc78f@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-acpi@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:14 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.


