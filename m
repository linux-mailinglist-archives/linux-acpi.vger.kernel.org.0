Return-Path: <linux-acpi+bounces-3807-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83D85ECF1
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 00:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A531F23DCD
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 23:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B1A12A169;
	Wed, 21 Feb 2024 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGG5W/pC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78008126F37
	for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558234; cv=none; b=NRbDUQo5yZ3VjNUudpbRuFvyWxNCQrXB1M3UN/uy/LxP2PDeEiQ7reZ9gMSrn9XNcfvoysA2fuUY5skgQBsLi9gU8IS6H8c7Cwy7TkmZhyQ2xeC3ogernL1qGdHdwKENdUIk2Y9i3nWbkMMfJAuyAftEMb3QgGpvVLHvO9inP+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558234; c=relaxed/simple;
	bh=rMfghQHSrf66m2xYpU7sUmwUlSg6uFRoFfJUQDk9JaI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=YluQUkY6mUCKqlKUs36nA6DNy5G1ln3wazKT2C64XSGDlRPwA5FA9S4v2fhaG2KOe5f5g7kwq8wXyOzKqrwVByFOWek6oDDKvbP9tqovyZQ3k+VXn+DG/F9c85Jjt6yzzVSCGZYloZjUt0ssLKpZc6NCIIbzx/s91mOwHrk3c5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGG5W/pC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b2682870so12163958276.0
        for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 15:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708558231; x=1709163031; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RsJ1fv6sfnN74ztB0VWfE18M80nrvJ6wlqEGStg9ZSY=;
        b=pGG5W/pCpowgB90F6DOeurXkM0sDYn2DGbPwU6oOalRQK0gqUbERNIDe39Oow7i9re
         3mkubDSPCtNrY3OhAfrvGEQ0ZVhTyoWAIUkDPVf3oDbuezJtVl/8fntnz30jA/aqyspz
         KgY59ihna18AXxR+UdUCaYRBTqGDJDL6oTHifkDfNZpCYOxdpVALsfnPYqt7NfQl93b2
         O6ZHzLkzTnOMkNPiyxm+vJS2dGIvo1mZoBJorw5FEoje2jSQVIOAz5E5bPfZgQJ6RdvQ
         TqoijWnpUN7/nEqoYUftm9oM3yIKwTvD/VdxiTuCi1T+CqIH7Y/iJYLcIS0bIYqPpwWC
         tAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708558231; x=1709163031;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RsJ1fv6sfnN74ztB0VWfE18M80nrvJ6wlqEGStg9ZSY=;
        b=AySX/z/Q2uuStGcMPIksyfHXhNSgo6FG2hRgAstSPrn6P9ohthv4zyCsVirCWWCGyv
         uohSkA4EIh5RRcTSW8G2Or0GOWG0nRXV0MWnoFN+cTYcsLnnAh5reU+zN1tmZthewvwH
         ixv8Zd7OOQIb0fmhaxrTFdm50aPR9xqo6dXMTCZVkzVroZLANRtxBPTrY0ZmJuuOAQLE
         extzvveF+pwCz4osl9FVEaqlGA0twy7kXI0fmjhkRdUioQEos9THl50kA5p6DkCq3W1l
         NWOW6tEzpOkAGaVfYyyAQ9z8ShnIxFTgOIthBrIyyzUbQd6X7cA/r2gmnQY+lty/TdyQ
         kIWg==
X-Forwarded-Encrypted: i=1; AJvYcCXgrIejeZsE8zJylgElpZtuxRViAHkHRclNsGBznvHHpRJhK48gwHNJXRAivR3vhB2n12ExNO6mxWqjSywF1jf7K3wEyAL5jPlocw==
X-Gm-Message-State: AOJu0Ywvitmqk12sAQn4edRUwR5OF7Rq0EHkqv0vTAzEBZGbwEe/PHai
	h/CLulGr4LGe/ef+CxbCFRHoZYbPX6N2OOeMfmNxwXThtxPVRXDXukuNda0pTpUhXrhpdtUZEho
	nqfAg+P2u0NivVQ==
X-Google-Smtp-Source: AGHT+IFFe6RGLehaGSPj902y32MxR8KvPs3Ay0pm4gQyZIEo/E/TTc10pIGjALHXPwbgNwcAARJB+YShim+SxHY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:4e1e:336a:2b30:13fe])
 (user=saravanak job=sendgmr) by 2002:a05:6902:1024:b0:dc7:48ce:d17f with SMTP
 id x4-20020a056902102400b00dc748ced17fmr199215ybt.10.1708558231444; Wed, 21
 Feb 2024 15:30:31 -0800 (PST)
Date: Wed, 21 Feb 2024 15:30:20 -0800
Message-Id: <20240221233026.2915061-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v3 0/4] Add post-init-providers binding to improve
 suspend/resume stability
From: Saravana Kannan <saravanak@google.com>
To: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series adds a "post-init-providers" device tree binding that
can be used to break dependency cycles in device tree and enforce a more
determinstic probe/suspend/resume order. This will also improve the
stability of global async probing and async suspend/resume and allow us
to enable them more easily. Yet another step away from playing initcall
chicken with probing and step towards fully async probing and
suspend/resume.

Patch 3 (the binding documentation) provides a lot more details and
examples.

v2->v3:
- Changes doc/code from "post-init-supplier" to "post-init-providers"
- Fixed some wording that was ambiguous for Conor.
- Fixed indentation, additionalProperties and white space issues in the
  yaml syntax.
- Fixed syntax errors in the example.

v1->v2:
- Addressed Documentation/commit text errors pointed out by Rob
- Reordered MAINTAINERS chunk as pointed out by Krzysztof

Saravana Kannan (4):
  driver core: Adds flags param to fwnode_link_add()
  driver core: Add FWLINK_FLAG_IGNORE to completely ignore a fwnode link
  dt-bindings: Add post-init-providers property
  of: property: fw_devlink: Add support for "post-init-providers"
    property

 .../bindings/post-init-providers.yaml         | 105 ++++++++++++++++++
 MAINTAINERS                                   |  13 ++-
 drivers/base/core.c                           |  14 ++-
 drivers/firmware/efi/sysfb_efi.c              |   2 +-
 drivers/of/property.c                         |  17 ++-
 include/linux/fwnode.h                        |   5 +-
 6 files changed, 142 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/post-init-providers.yaml

-- 
2.44.0.rc0.258.g7320e95886-goog


