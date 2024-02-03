Return-Path: <linux-acpi+bounces-3208-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0DA8488AD
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Feb 2024 21:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A112823CE
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Feb 2024 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715485FB86;
	Sat,  3 Feb 2024 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNQUe44G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7095FDC2
	for <linux-acpi@vger.kernel.org>; Sat,  3 Feb 2024 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706991594; cv=none; b=dgS1qkG9wUrM4zHpYPwxDA7hkvPazU/iPbzjyIrjat74bC3Cib9JWm1yoDNuRHwIuFo9sWjJ+xzGY59EZjbTGlv/a4MFjlZlSrEpFc/fntBl355GPJnfPZ50DVkaHnkVt+6JQpyyhayS/SmM2VnVc2QwiKbxq0eNLYmB37UHYKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706991594; c=relaxed/simple;
	bh=/tIOfZiPDV1D/juSGkOzPztaXFChFG+xlPW1MQWVfiw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bEO7AtpejV54nZigoE1iUZNcKU3ODtSxH6r5S9KSJE0SPg9HnFFmyn+zKEx3piga8h6HTKqBFPw8WoURyUZoqh0IKq2lEXelxcCShZTq0CdfTlkVk34WwdbAvHmLqS39whIq0vQ4GF0K4cbDsS43Ki2m0X91msopD3qgXzB3oY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNQUe44G; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-295c67ab2ccso2508853a91.1
        for <linux-acpi@vger.kernel.org>; Sat, 03 Feb 2024 12:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706991592; x=1707596392; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/tIOfZiPDV1D/juSGkOzPztaXFChFG+xlPW1MQWVfiw=;
        b=HNQUe44GwzDWOW2zbrg+EIoi4emy+zdIMEBPZfW0hFL0Wc4gjMybW/KYEeYh8dRZWv
         aafF7tr5JYhGBUs0BJJOkkvqEVAl7/byA0M9pVZAhAfUiP85fz4Lj8rOjOPtqXFd/4br
         ORhsjba3MjMF3hMuWpmw7YZ6X2LjSLtvEWqU/6YTEn4JdnQvHZNJKIZZHQCsWhXmXCFp
         Xq1wbohyyi/4OBvJz98Zmwa73YIntP/9BADqL7rXxm1vJssIVOdzPNOUjxXQgHmlW0lr
         krA2vlUrXqw6ioRQfwmeSR8paaXMVsl7NrykYQoHE1U/FpToDs/+fQBazw7MkMF0NwJw
         47UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706991592; x=1707596392;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/tIOfZiPDV1D/juSGkOzPztaXFChFG+xlPW1MQWVfiw=;
        b=oSb31KXaSi+BjGRTHpUMZvFYTzuEMIg8HJM4vWhm32d909b4bokoryKJSq9h14Myp7
         4PqqGcTJFck9NRoSCO9e4SPoSjer49zhf4SNmRe5BBvP6JrDrdvYIdPXcMUE8wu2Dyjc
         kFvg/8bfPtX8OiEccRApwweg9dx1PIEu5yv/UCPqNUhOEzJOf00/ggM24fihT/7KTx2d
         /LIA/zVBkzwbh8AcusRA+roZ1bFmxtbl47MCWyf2Gt9J4QTARwgarLH+ViO4QFoSPruK
         qv6922hpQBbNnFJzRKmp9+0hJ9etlcyPF+8pfBSyi/cxbcQw9WiqYJ1NYr/GNspoD89n
         TMBw==
X-Gm-Message-State: AOJu0Yx2NV4P0cvxRYbH/58uA/zVrryaMOlEjoBZ23ilTBRsi36oEegp
	XQUPzp6s4BSpVLYaKHnBFps6vZTJ40SZhO6f4ZMd226oktBfnK1tikvaCK0La/bMUxRaQuD+ZHc
	DQamohYuZKVTsyyNV9uel7cKhD30QQrBqGP4=
X-Google-Smtp-Source: AGHT+IFQ8A22yTcGvevaPrcUCfjo3qys5k3gDM7A3eyjvVaARJ4q18E0AfsP3BDQBKE9kLeAuv3iwEUAC46J8xBgirM=
X-Received: by 2002:a17:90a:d18f:b0:296:5abe:a862 with SMTP id
 fu15-20020a17090ad18f00b002965abea862mr3086991pjb.9.1706991591976; Sat, 03
 Feb 2024 12:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mateusz K <mateusz.kaduk@gmail.com>
Date: Sat, 3 Feb 2024 21:19:40 +0100
Message-ID: <CAPf=4RfApxgPg-2XiM0hhX1ykeRthg2NLjmCSR9vhcTm7_s0CA@mail.gmail.com>
Subject: AACPI Issues on Lenovo Legion 9 16IRX8 83AG with Recent Kernel
 Versions (including 6.8rc2)
To: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux ACPI Community,

I am reaching out to report a persistent issue encountered with a
Lenovo Legion 9 16IRX8 83AG laptop across multiple Linux kernel
versions, specifically 6.6.13, 6.7, and 6.8rc2. Upon booting with
these kernels, the system logs multiple ACPI errors, which seem to be
at the root of several hardware compatibility problems, including but
not limited to, intermittent interrupt issues, the battery status not
being displayed correctly, and the touchpad being unresponsive.

This issue has been documented and discussed within the Lenovo user
forums, and further technical details, including dmesg outputs, have
been provided in a Bugzilla report
(https://bugzilla.kernel.org/show_bug.cgi?id=218444). The community's
insights there suggest that these errors may be indicative of deeper
ACPI implementation discrepancies that affect the laptop's
functionality under the stated kernel versions.

I would like to ask the community for help or if there is any
additional data or information I could provide which might help
resolve this issue.

Kind regards,
Matesz Kaduk

