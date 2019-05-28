Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16BE82BD9D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2019 05:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfE1DWP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 May 2019 23:22:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36055 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfE1DWP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 May 2019 23:22:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so7717313plr.3
        for <linux-acpi@vger.kernel.org>; Mon, 27 May 2019 20:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=babayev.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txkPYx4kl/dbr2peXVzI1JFIF8M0v7UB6YuZExmYRSc=;
        b=RPgmgTE070YVO9U/nSaukvceq0z2LI7bXy7zOuS7TU8p0LInnNih5j7BECvhrURzaA
         mxTWhkNYa0Z3IJYe8lRswb0XVbKZ1NPbn9sPGi4X3Xyox5YK5GvS7Co/yvOtqoxfx/4h
         k+xL8PEz2ZonoAumksNuC7eI6sg2A3y13B01I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txkPYx4kl/dbr2peXVzI1JFIF8M0v7UB6YuZExmYRSc=;
        b=qo/++YOvL/3fUrOck50gMbmc2EBbTzEj9SL5sSGSiNntZGE1qNo+7/C2M0bNaYVpAS
         3wtJyQ6TZff7ddt0oMotWuOzVPLdNwhqabSJQFt/WoTs7gk1PcSQ9u5rT9t++qAxqDBt
         MEVpeUbxQDtRJnRnP4W1H/QY7ntz+MkOSqGYxP1NbdVVEVhtmz+sKcYNxKQS+IBUEkl/
         itXRt4k8/O2JuMslv1mU+8FdKySsJgoFgOcOHkbPCg/vrCrZdgOSJIG66fe1L7bvcWmN
         zujHy1PyD2Np7AUY81Fk7z00fTd5DBeTqXH42q5K3nsJ9LIZYjlwigJEaBsqHgHyt9j3
         Zd7Q==
X-Gm-Message-State: APjAAAUGpA9V3MT9tsUN1zc+U+4bieSLzT2ZiOTVVSiYrcFgkJ4Dq8GS
        qXJbJ3nWTAZUSeyfxxuSDEz05w==
X-Google-Smtp-Source: APXvYqxZ6q0wb4tst0o7iW9zQi1zpzrRqJ4aOJnY2Q1Qy1NYBL2UVXh9DmnyYdL6fagHbkPJ7Ew49w==
X-Received: by 2002:a17:902:121:: with SMTP id 30mr2837278plb.314.1559013734376;
        Mon, 27 May 2019 20:22:14 -0700 (PDT)
Received: from p50.cisco.com ([128.107.241.177])
        by smtp.gmail.com with ESMTPSA id h71sm933042pje.11.2019.05.27.20.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 20:22:13 -0700 (PDT)
From:   Ruslan Babayev <ruslan@babayev.com>
To:     mika.westerberg@linux.intel.com, wsa@the-dreams.de,
        linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [net-next,v3 0/2] Enable SFP on ACPI based systems
Date:   Mon, 27 May 2019 20:22:11 -0700
Message-Id: <20190528032213.19839-1-ruslan@babayev.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Changes:
v2: more descriptive commit body
v3: made 'i2c_acpi_find_adapter_by_handle' static inline

Ruslan Babayev (2):
  i2c: acpi: export i2c_acpi_find_adapter_by_handle
  net: phy: sfp: enable i2c-bus detection on ACPI based systems

 drivers/i2c/i2c-core-acpi.c |  3 ++-
 drivers/net/phy/sfp.c       | 33 +++++++++++++++++++++++++--------
 include/linux/i2c.h         |  6 ++++++
 3 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.19.2

