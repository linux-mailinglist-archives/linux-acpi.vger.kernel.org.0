Return-Path: <linux-acpi+bounces-4100-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE0871514
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Mar 2024 06:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6423E1C2136F
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Mar 2024 05:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288845972;
	Tue,  5 Mar 2024 05:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ts+ff8gv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501144361
	for <linux-acpi@vger.kernel.org>; Tue,  5 Mar 2024 05:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709615105; cv=none; b=ZmjBwjDFekt1pIC+2xqvGlmgE1lBddkO0EzPusa4mm6pyeKmdx9veE6yb085q3Ot9G2Gg/nUOMzei7kRZtn5sV7M92vj80aPuBY1HLhgLI67fOPidF7mUFxaRHMIjsKFt1GXvAwH7fc58Cp3GxwopSyO/yK0JtfbReGhEvC2RZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709615105; c=relaxed/simple;
	bh=MAU1kWPqdnXGrNHYK3e1ZUDdxmqyA52aEjVKNf7L97s=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=rFzMnDSYyAq098C6+vzqwszkUVQBnje9R3EkLNC8T8woFujE8+9n86aOv44ns0b8GCU2/J2mY/O2cf5saJ1dkcvgXgUCeglCAEacH0NEPEGDNti7fiiiPT/KtzEGl+PA7aDNWuxOi5EI/7MOGpZ1QLZ6lpgDVxBuxE4HJDbeZa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ts+ff8gv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so7220917276.1
        for <linux-acpi@vger.kernel.org>; Mon, 04 Mar 2024 21:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709615103; x=1710219903; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q4xpip56iqsz0ZA+qjMQdeYvZuGJ4xYG5vF66MG0lag=;
        b=Ts+ff8gvPAXuRVEUHnF5LhhM2KBRL97o//wcOi+dva5TtUSU/SIm+4HKuCyZtwP42z
         hYYEcCMTb4qwCtlm/8RVWZRsV29Cti9Rid5yB2qeNjqFwURHKTmh/WxztubD0khaJpfh
         qxm5QoHqv6M5ypgvknUeZW8lBbp3fRsjPeb2BakOe63DpCP4CW0mHEtwqXzl5F1rrGc8
         qYF16GIKA3Oh3X5SbjYOO1HTW25/6sRvms9p8UkWs25VfeI+UCTJXVkCFtmASW/lX2ug
         WmTXix8GqYRlH0yBFMEke8Q8p4xsgIzTxZr+3tlcP+7E3HbI5Eb54blp/T/PzB1rKG+F
         5oVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709615103; x=1710219903;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4xpip56iqsz0ZA+qjMQdeYvZuGJ4xYG5vF66MG0lag=;
        b=YrHEKnQCrNsSaMMEywjhU5L+2nP9MBOSKksS9oLqqpVJe+2rNXa+RkCaIlyKtiqetU
         g3bnJLFhMEwUiFWE1DjO8H5K9updmlpDECYT8jxgbCugIeBvhi3Zt9weePj0LJ6jizt1
         hC8AZ364Wlg3Dam+HztIzmQmjIx5Xupva+E/KI5n5adUMutKap/1chiqT+Pv2x6UnR2Y
         26LVROYxwqlDrGZ1FmqJgpSUaqUr1XE98XRMBpjK9geDTGDyWzd4nkb1om+B/rTSbzmp
         2z3Ikpcu2IWCrtY6HTPujC5KkrHnQj4dtFOOXzKsDd9rikwri8iAisfld4Dy+89VYA8j
         jXjg==
X-Forwarded-Encrypted: i=1; AJvYcCUgSoX2+XBCpJ6deXJD/4hfCjbRG3+TmZwaIqvCq94iGhKRbYuEhQTiS++dxoST1HpoMXVDxWaEki9+mzhbd2P8t2yIglIYY5XoOA==
X-Gm-Message-State: AOJu0YyQD0QOoud2Cx+/r1yOmE2zftyE7aplfU9T4DgKa4VsHrPmWtnj
	DcQ7nvid4OsdB3UXT/VDRlF9A2oJ7NeWI9TCdVTMh0YoYyZ22pP44wIRB9boW9hJ+ortCs3nkT2
	5cazUuqXKy126QQ==
X-Google-Smtp-Source: AGHT+IFo+LnxDdPsW+MOrOqUjpVCkgB+n9r+MxXeQAnbHnQl5NgTJGxOR5lY11wswnsYWorkDIHWiDj499TxTto=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:d64:6ee3:55a9:46e6])
 (user=saravanak job=sendgmr) by 2002:a05:6902:70d:b0:dc6:c94e:fb85 with SMTP
 id k13-20020a056902070d00b00dc6c94efb85mr376493ybt.2.1709615102823; Mon, 04
 Mar 2024 21:05:02 -0800 (PST)
Date: Mon,  4 Mar 2024 21:04:53 -0800
Message-Id: <20240305050458.1400667-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v5 0/3] Add post-init-providers binding to improve
 suspend/resume stability
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greg,

Can you pull this in as part of your tree please?

Thanks, Saravana

This patch series adds a "post-init-providers" device tree binding that
can be used to break dependency cycles in device tree and enforce a more
determinstic probe/suspend/resume order. This will also improve the
stability of global async probing and async suspend/resume and allow us
to enable them more easily. Yet another step away from playing initcall
chicken with probing and step towards fully async probing and
suspend/resume.

dtschema update for post-init-providers will have a more substantial
documentation of the examples and the need for this property.

v4->v5:
- As suggesed by reviewers, removed line wraps to go > 80 chars.
- Added Reviewed-by and Acked-by
- Dropped the DT schema documentation patch (will submit tha to dtschema)

v3->v4:
- Fixed MAINTAINERS file to go with the file rename.

v2->v3:
- Changes doc/code from "post-init-supplier" to "post-init-providers"
- Fixed some wording that was ambiguous for Conor.
- Fixed indentation, additionalProperies and white space issues in the
  yaml syntax.
- Fixed syntax errors in the example.

v1->v2:
- Addressed Documentation/commit text errors pointed out by Rob
- Reordered MAINTAINERS chunk as pointed out by Krzysztof

Saravana Kannan (3):
  driver core: Adds flags param to fwnode_link_add()
  driver core: Add FWLINK_FLAG_IGNORE to completely ignore a fwnode link
  of: property: fw_devlink: Add support for "post-init-providers"
    property

 drivers/base/core.c              | 14 +++++++++++---
 drivers/firmware/efi/sysfb_efi.c |  2 +-
 drivers/of/property.c            | 15 ++++++++++++---
 include/linux/fwnode.h           |  5 ++++-
 4 files changed, 28 insertions(+), 8 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


