Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB6056F72F
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2019 04:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfGVCgB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 Jul 2019 22:36:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36815 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfGVCgB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Jul 2019 22:36:01 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so70695923iom.3;
        Sun, 21 Jul 2019 19:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m9WKZA0z6Cfv73HWP42zT48QZr6ihI+Pkv7TUGFSRDQ=;
        b=tt1r2NuqhTHbD5KNqImG3Uu9Qi61IIA4yI+2u//2PrwrRSddUWtmG+CMk7Nnebn87Y
         jXzWbJGEu8DYJCnw9YtBE4gGcQbXJbdfkncObA0geX8zyvw8g4yUl7MXNAlSFskMV0xu
         RVzZtt/NCcMFNgdpX1dOrYl4l1aAO2p1lcMi37btWNOvw0w+kyXafMoqcJoCz3X0uxjs
         tMsRgErh51JrjMT/Q2Rj9Thwni5Kyc+fQ4OR635q4S952w0xnQ+hxHp/GXegmmhk8SNz
         vM2ykytPGrAIRiVEO5CKqNlkD65T1abGaCzr0rsYq8zFQZ6viHxZPUWkOL6XNjyoMX9b
         M3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m9WKZA0z6Cfv73HWP42zT48QZr6ihI+Pkv7TUGFSRDQ=;
        b=dBCjkqbP/G9IQX0hdzEw/VHpdtmDzOje8cAtPGQhqbtodB4EymKmi9ZtvgRGkjw7Dg
         XAYfz2NDTctaOcKevoWrbs1P2ElMdGGGclCwUPViT1wwqedl9uhOtr7dYzvDmcKZgFwf
         n0OSWnLqSN72t8C3IDLHZ9H9jIdw4OqxeBsdTWCOEcHc30F3bZfOV2zddxbzYKp8KjLi
         ZzN0Fkuvw9w5ItIyK0MTEqZf40Lu/0kWF6bsf78yBF9RJCekKAv3HPaHIlci4zfN19Ka
         Gl/0qQnNuWFHaicAmvIsfv10da8dFqFOUQeWry0QsftXl1XW/JF/uzcy17E79AYM7DBM
         w7lw==
X-Gm-Message-State: APjAAAX+s2hanz30eQKPkbUNVWhsWdGyTVPyttSrGuBmb4M04+LjkVBl
        lncLffiMjOZm496HsgbGh58=
X-Google-Smtp-Source: APXvYqwuxAfOFpPdoVpzR4e9/8fk3CBrl2BpDVphXA9XxnaAOd8TVQZqap56eUINqgC4RJVG0rMqMw==
X-Received: by 2002:a6b:bc42:: with SMTP id m63mr48115007iof.189.1563762960894;
        Sun, 21 Jul 2019 19:36:00 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id e188sm32816577ioa.3.2019.07.21.19.35.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 19:36:00 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, bjorn@helgaas.com,
        skunberg.kelsey@gmail.com
Subject: [PATCH 0/3] ACPI: Remove unnecessary acpi_has_method() calls
Date:   Sun, 21 Jul 2019 20:35:27 -0600
Message-Id: <20190722023530.67676-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Remove acpi_has_method() calls which return an error a following call will
provide anyways. Removing the unnecessary acpi_has_method() calls help to
clean up code and remove extra work.

Kelsey Skunberg (3):
  ACPI: Remove acpi_has_method() call from acpi_adxl.c
  ACPI: Remove acpi_has_method() call from scan.c
  ACPI: Remove acpi_has_method() calls from thermal.c

 drivers/acpi/acpi_adxl.c |  5 -----
 drivers/acpi/scan.c      |  3 ---
 drivers/acpi/thermal.c   | 11 +++--------
 3 files changed, 3 insertions(+), 16 deletions(-)

-- 
2.20.1

