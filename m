Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2755EF3ECC
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 05:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfKHEWb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 23:22:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47072 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfKHEWb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 23:22:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id l4so3147872plt.13;
        Thu, 07 Nov 2019 20:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bsHHvOBHYSAwyOJWpwTq18Yce7fksGehropOPjwveQU=;
        b=XviJnGPlRiGvHDAknKAEp6+uZ06F5qFYdmClT+t1laSuYN7lYJ2fHuP2gkh4StGgQd
         7vye0Q78qoIIskwHTdOTV31mAPsqSrqSuy35sbOQBbvVhGcF7JvoWWawXNQEyVcZOgIE
         sFh+sdjt2pkTY41fHDRT79rZC21j6VoHrupgLryEbIjzloynr9vmpKQJcJCZRiqzea+y
         8Gq0hDuuqly7Hhf0q1rHMQZZGbkf7mRBD80tzFtxxRbEo9dA5zHBErm2LRCQR+yDZrNy
         5cHLvn8ppCOsgNHgImq/brhun+SRRa1oVlllGK/sc2klVChl7lu4U0srUM97q65yzQfh
         rhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bsHHvOBHYSAwyOJWpwTq18Yce7fksGehropOPjwveQU=;
        b=DGul+aWQcuz86GeHRpFKXp8AICAQcwIQEED0WhjnRAwjwCb4XbgvYHtq6nVVILZLND
         Uw/DmWSE7NDvEEny8Z2FW1mdXPygn9+fHjtIHViA47HQRFnA8uBo1kzhIoHFFa/qyGNO
         K7fagubo1ctNHK4Na3/ij2VOiFVIqsnPyy0vxs+hbND6d1h5aE6C5j8xWllE2AHTZvg+
         HF0cZlFRW6NamOEKG5k/EPT+uxg/o8NFGMvsyxx8bClbzbBVO7M2qR4E0fJhPt1oMshy
         1hxeObh5a4gASI3Vid+TJBgBkANJ3T8Z+6f0yN1+hwpFBs9FIsSraSm8uvy2qd0Iwfp7
         hSEA==
X-Gm-Message-State: APjAAAX8cP+MaFwnw8ZwJwmSJSlD5sckrCSllarOt4iLm2LwlITg+5Rd
        +OVlcE9mH9dQPv/FsFB2DuU=
X-Google-Smtp-Source: APXvYqzOC0bSC/aqHraKHYXw5RIG6S56oWe92GuTqg9nRXJYRZc6nSTsAAY/d2qLO6xJiO4LOKyfzA==
X-Received: by 2002:a17:90a:fa96:: with SMTP id cu22mr10457393pjb.121.1573186949793;
        Thu, 07 Nov 2019 20:22:29 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 71sm5004106pfx.107.2019.11.07.20.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 20:22:28 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v8 0/6] software node: add support for reference properties
Date:   Thu,  7 Nov 2019 20:22:19 -0800
Message-Id: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

These series implement "references" properties for software nodes as true
properties, instead of managing them completely separately.

The first 2 patches do away with separate handling of arrays vs
single-value properties, and treat everything as arrays (which really
matches how we handle OF or ACPI properties). Instead we recognize that
data, if it is small enough, may be embedded into property_entry
structure. As a side effect, properties can be converted from having their
data stored separately to embedding their data when they are being copied.

Patch #3 implements PROPERTY_ENTRY_REF() and friends; patch #4 converts
the user of references to the property syntax, and patch #5 removes the
remains of references as entities that are managed separately.

Patch #6 adds unit tests to verify that the handling of property
entries is correct.

Note that patches #4 and $5 can be postponed.

Changes in v8:
- switch data members of "value" union to be arrays to clearly show
  that even when embedding we may be dealing with more than one element
- when parsing references use property_entry_read_int_array() instead of
  fetching u32 value directly from nargs property

Changes in v7:
- rebased onto next-20191107
- dropped already applied patches
- reworked patch that moved small properties inline on copying to
  avoid temporary allocation
- cleaned up logic for embedding vs storing values out-of-line
- fixed handling of embedded 2-element string array on x32

Changes in v6:
- rebased onto next-20191023
- fixed patch moving small properties inline
- fixed handling boolean properties after is_array -> is_inline
  conversion
- changed comments around is_inline "stored directly" vs embedded
  in one place (Andy)
- added unit tests for property entries based on KUnit framework
- added Any's reviewed-by/acked-by

Changes in v5:
- rebased onto next-20191011

Changes in v4:
- dealt with union aliasing concerns
- inline small properties on copy

Changes in v3:
- added various cleanups before implementing reference properties

Changes in v2:
- reworked code so that even single-entry reference properties are
  stored as arrays (i.e. the software_node_ref_args instances are
  not part of property_entry structure) to avoid size increase.
  From user's POV nothing is changed, one can still use PROPERTY_ENTRY_REF
  macro to define reference "inline".
- dropped unused DEV_PROP_MAX
- rebased on linux-next

Dmitry Torokhov (6):
  software node: rename is_array to is_inline
  software node: allow embedding of small arrays into property_entry
  software node: implement reference properties
  platform/x86: intel_cht_int33fe: use inline reference properties
  software node: remove separate handling of references
  software node: add basic tests for property entries

 drivers/base/swnode.c                         | 154 +++---
 drivers/base/test/Makefile                    |   2 +
 drivers/base/test/property-entry-test.c       | 472 ++++++++++++++++++
 .../platform/x86/intel_cht_int33fe_typec.c    |  81 +--
 include/linux/property.h                      |  98 ++--
 5 files changed, 655 insertions(+), 152 deletions(-)
 create mode 100644 drivers/base/test/property-entry-test.c

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

