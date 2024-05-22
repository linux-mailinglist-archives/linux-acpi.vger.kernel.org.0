Return-Path: <linux-acpi+bounces-5932-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255538CBD97
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 11:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B851F22E40
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 09:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780757FBAE;
	Wed, 22 May 2024 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5Dlvz+f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C19282E2;
	Wed, 22 May 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369497; cv=none; b=H8M+iPau1mGG1EtYAQyUiC2HzKQKSsLVNPQ4iVPMewEsLKEHPX4VHq0E/5tLATGXbz9CxAERR11DAGGkVAT+z66IXM8WkIOWnjp9YXU7hZPWmlwsI9FJkZoBHPS1GbHVMv1gWUC6z669KXsQP3b9L362yuqh9Kw7hhV9jhpVDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369497; c=relaxed/simple;
	bh=Qr6USar02b6JYI0XqhLNAvs2zSTmqw+SpOFyKARZyC0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k8GlyRuWFHiChms8wxzErDy96pwDDSgW+fNZ3ltzGGz7DdQOyL0aiOWK5+UATdSB5ySyTioWwAkJjFjK+F4YiSszOg2ARauk3nDbySwYRGsEIlCA8wsdOMPtoE7GVG4acq0US4tA9bGGcR2WX7/yu0dKRbXHN2XfFQw1P+cUMAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5Dlvz+f; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59b81d087aso917513266b.3;
        Wed, 22 May 2024 02:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716369494; x=1716974294; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=epqJO+ERpctNPXshaXqEX2wabNsS9uehY5up2W7EJXM=;
        b=l5Dlvz+fH33aWy94tUx/IHFrD50CHNRnNtC4+g74kdkZtuXpOvAH25C3MH2pyuaqDq
         MPgfgMgojnW0BPstFJVB9c4gtpv/VpSOj6eM9qdTtKzRibZ6Plzqne16skhoFJR43mhk
         PHG7sO5UCmQdFr0WTJS+FiI1fVhlnppvfvyl8r2WxFS9MZUDLRIKVlWjpcT1ZBYkezdE
         A1EBa5Fa875/c3jtsqzaqUYqUP0a3qlTI7ZtqoN5vwk+zx8uMyAfbbHhjcPntkZxNOLO
         FzL/UUqKK/kRr/TbqpI+omteT4eoLvSyXp6YT64vSVNifhcGH3TncN7yaVukestzOJKE
         3w0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716369494; x=1716974294;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epqJO+ERpctNPXshaXqEX2wabNsS9uehY5up2W7EJXM=;
        b=vxFAse96NaELpxaOizPBKMzH1YSBa5JbMyaXPISPsLdnmHSxcGbxGEStKjQCj2KhIS
         ER/mr/uJ9ejNp78QxGP7yCfa3r2GAQL3U5NW7dQBtwG4uBDM6l0FWIfLxnj3QMRvujTi
         dqMcWOV4KO3OS4ljQtWG//MUGg63vY+npi8t+VxRWo8WXj011lfLo39A2XwW917eYuK1
         tgDo7dupkpISo7kHwKy+IOzTVbpzmZLtVnM7qlokw6fPtRwGQQo2tpYixzD9J6rq2R8n
         KdLjfcsTUNGgWcyFLuIxQGzvahVhijY/wJmsX4tZkBKozJWS9qPVXxRwZ3OmtfAPJkca
         cHuw==
X-Forwarded-Encrypted: i=1; AJvYcCXTg3gn/Mw7DcmTAbbnlxXUOs81lGhjM+sIYbb3wpYUlCHqQEQkwh01d6jD3gJ8xKaprNWC58Lc6VsTXD2PUxgOSjaPpuzQ+LRLIifJBGYHtvjV6DTZftVeS9OE/vGLQM50gu0yjR4jtYE=
X-Gm-Message-State: AOJu0Yz3/tCLH7La5uea1NbOkI5S9qzZrzBU5ztsVkAdy7Vd5mPB+s18
	AaSy+za5COy+PSuK4BBFDrIykzdInm9KUDCoZtDhp8fRdHJEeE2b
X-Google-Smtp-Source: AGHT+IFHKz6NYWtpbZOxJZ2dVbmmDeU/KEXReIfxPv3+43K7ZjjdiDJ1Ck9ql7NsX8Lk5E5mKdnTHA==
X-Received: by 2002:a17:906:c34d:b0:a59:ba2b:5915 with SMTP id a640c23a62f3a-a62281e11d5mr143893266b.50.1716369494032;
        Wed, 22 May 2024 02:18:14 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cec3d9b5csm836678066b.16.2024.05.22.02.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:18:13 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] device property: introduce
 fwnode_for_each_available_child_node_scoped()
Date: Wed, 22 May 2024 11:18:06 +0200
Message-Id: <20240522-fwnode_for_each_available_child_node_scoped-v1-0-1188b0da12dc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE64TWYC/x2N0QrDIAwAf6XkeYLaDbb9yhiSxWQGRItCNyj99
 0ofj4O7DTo35Q7PaYPGq3atZYC7TEAJy5eNxsHgrb/am3dGfqVGDlJbYKQUcEXN+MkcKGmO4bS
 d6sLR3MWJfcQZnSUYxaWx6P+8vd77fgDv54G6fQAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716369492; l=1324;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Qr6USar02b6JYI0XqhLNAvs2zSTmqw+SpOFyKARZyC0=;
 b=skBC7zUYZmBdaCrkmOdXDTE2PXaZlyW5JfOQ1Hg+XTKbj89cB73pX1/WLeRvLF9XxGkP6ksJt
 l5P3CeIJplEDwPzIAUgDjPQvFfDXwvnqeKjyZpRX5uhwDc/nFvebP9g
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The _scoped() version of the fwnode_for_each_available_child_node()
follows the approach recently taken for other loops that handle child
nodes like for_each_child_of_node_scoped() or
device_for_each_child_node_scoped(), which are based on the __free()
auto cleanup handler to remove the need for fwnode_handle_put() on
early loop exits.

This new variant has been tested with the LTC2992, which currently uses
the non-scoped variant. There is one error path that does not decrement
the refcount of the child node, which can be fixed by using the new
macro. The bug was introduced in a later modification of the loop, which
shows how useful an automatic cleanup solution can be in many uses of
the non-scoped version.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      device property: introduce fwnode_for_each_available_child_node_scoped()
      hwmon: (ltc2992) use fwnode_for_each_available_child_node_scoped()

 drivers/hwmon/ltc2992.c  | 11 +++--------
 include/linux/property.h |  5 +++++
 2 files changed, 8 insertions(+), 8 deletions(-)
---
base-commit: 124cfbcd6d185d4f50be02d5f5afe61578916773
change-id: 20240521-fwnode_for_each_available_child_node_scoped-8f1f09d3a10c

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


