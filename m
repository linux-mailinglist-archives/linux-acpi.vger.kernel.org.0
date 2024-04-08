Return-Path: <linux-acpi+bounces-4781-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E81BF89CEB9
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Apr 2024 01:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BDB51F22804
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 23:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F1E143872;
	Mon,  8 Apr 2024 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfUfF1PX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B31DA5E
	for <linux-acpi@vger.kernel.org>; Mon,  8 Apr 2024 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618003; cv=none; b=KH09SrhvSrQ3DI0bokZPD+oStQveI3wPMFvIel7vzaH0a8KiPrfTcZ35r1/yDu+M6PAAGhgrkSa4tpW5fVRXILLVinskShIJ1PI/IKgy2aubdCQBT2YNt1yAaNdIMqMvQa5hpOtIKY9K0SACbnQpcAKAXeeKFPBkffg5FPPBVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618003; c=relaxed/simple;
	bh=x9mwVZCtRJZxj4SxW0pxGiYFzzdRxitCW4paJ8e6Vwk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=nFZ4jLOUQ2sOrLbl65fh9FMAD11Ehkhz+CKvw9uZDWkIoXDEoUGD/2wH0j+xRcxZj4fpT5sEgOZbKD8iRD6HUDfZ3d0/Pf2Vtv0aDecwVy36PCvVicD9/hw/YTtqs/tHCbUB/xnGXLHfw8tI4qKe3sYs/ZeGKnbTtXqFZ93YJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfUfF1PX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-615110c3472so92954557b3.3
        for <linux-acpi@vger.kernel.org>; Mon, 08 Apr 2024 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712618001; x=1713222801; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8KR9ZDVpmFlaIwvKuBx+EnAZl+aysJrEDZLL4TycsvM=;
        b=tfUfF1PX/ufUeMkiwBfJE8B2Dbxw/WmajPZ105zDKfBVIZ9eg33wauBAvVOhenKp21
         VTV5ca2mPMiwo7MsCYkqY/lcPrZG6qt3iV7crDBTqHL0ilpvMQkJCpOJBt4wXSvXM3gq
         QoqN/pHlRJyr8flcdomG8fpD5nybyDE3XUaxXPOUuAxUL53EZxUH1EG6kM39g+xnlsuP
         W/uURi2mV+pHGZrnIVRJKSW9yqUAAJ2fOb5e+8T1oPFXMBIC2S2/o9PLZXmAK/cdIx/c
         RCqsu+EW59nXMSN9ugUboQy1VxMdtz8p0HoZKGSAMmQ29lqt+dLEnrg4lc+2lbow+DBJ
         zGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712618001; x=1713222801;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8KR9ZDVpmFlaIwvKuBx+EnAZl+aysJrEDZLL4TycsvM=;
        b=AWuQ4swy/wN67GA5IcXhkDL1N3XPMmsucq2Hky33/e0rpbV9qx+Ni9THYDPllOEUye
         2ZXB3xy9oZEQXRo7WX6g1/AkDVblLyf78V5gQ99egv582eGm0U08Boy2K92XuVSSb1WO
         vHpgy7r8ib02Rf1zLnC+cJUlQevPljUxJEp0aI33dRfswHmXrfnm4Gs8HS9wb+zzOZAG
         DdDzniY1rk4xTksQbdejEKvLs/r4hYbg7O+y39X2MZb85FOayAys8QJPXbhe5YB47A6g
         KI1LEUAyCEnMOnlTJ+bR6/0rLoBFSOjvGkGtzcWUImvMC1OHHK0Qwvq9LTZs1nwXoI5S
         Pt/w==
X-Forwarded-Encrypted: i=1; AJvYcCX8FbXB6o6cQLYJF85bVEyTa+fhWFMXwU9Uw8Z0hAxzal/ih/e01nx+nQ/AbTTOYMOHcnFcbtK/qtP9MpK0H6+V74MxMvyUXQ0/FA==
X-Gm-Message-State: AOJu0YwiPwufpQTV3wYtADM8SxAPJ2ibcM1HK6gK5a2JcF2R19ENCqqP
	/gO7R0NAzHd4dYlXgzaSz8hW1sLlgpOaa0dyi9PFHpCeVO2KjMlpMnHmA/tQYbKogGe43GaVjSq
	Spokggbztd7pxMg==
X-Google-Smtp-Source: AGHT+IEiBKuFp9QTgBmavvNyeuDLhVieZKacyXA60iTXYXv5owwSC1k0jFYE2SUKHElIfDGTrdBpXZCX+VZqUfk=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:96d3:321a:67f3:5322])
 (user=saravanak job=sendgmr) by 2002:a81:73d6:0:b0:614:2c5c:d275 with SMTP id
 o205-20020a8173d6000000b006142c5cd275mr2854389ywc.4.1712618000795; Mon, 08
 Apr 2024 16:13:20 -0700 (PDT)
Date: Mon,  8 Apr 2024 16:13:07 -0700
Message-Id: <20240408231310.325451-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [RFC PATCH v1 0/2] fw_devlink overlay fix
From: Saravana Kannan <saravanak@google.com>
To: Herve Codina <herve.codina@bootlin.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Don't bother review this patch. It needs to be refactored better once I
know it works.

Geert and Herve,

This patch serious should hopefully fix both of your use cases. Can you
please check to make sure the device links created to/from the overlay
devices are to/from the right ones?

I've only compile tested it. If I made some obvious mistake, feel free
to fix it and give it a shot.

Cc: Rob Herring <robh@kernel.org>

Thanks,
Saravana

Saravana Kannan (2):
  Revert "treewide: Fix probing of devices in DT overlays"
  of: dynamic: Fix probing of overlay devices

 drivers/base/core.c       | 10 ++++++++++
 drivers/bus/imx-weim.c    |  6 ------
 drivers/i2c/i2c-core-of.c |  5 -----
 drivers/of/dynamic.c      |  9 ++++++++-
 drivers/of/platform.c     |  5 -----
 drivers/spi/spi.c         |  5 -----
 include/linux/fwnode.h    |  2 ++
 7 files changed, 20 insertions(+), 22 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


