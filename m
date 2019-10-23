Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07CE0E2397
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 22:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404918AbfJWUCj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 16:02:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37155 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733176AbfJWUCj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 16:02:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id u20so10630470plq.4;
        Wed, 23 Oct 2019 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAiZDfyravkgmTU87XNbWaKqoZ4BUrbWmy/iiYcxWto=;
        b=PkxDXsmrJtCZqq+Po4xpY90pQ2PWfcTTC29eIcfKum63aYsxcJE95Oh/PxKy52JqW2
         +1B12jxxmVpboqtdMCHyqx46NYQme479sFmxFSEfBNWiqhoSe+AKEzTWNqs/AIpk1GvI
         cwiKNga9nObNHHESK1L0VCl06OiR3264z4SDrJEEEwHzDAfjOoL2YY6QhbVWd3Ql8mDV
         pnZv7YzjGwJH4THAVuOiKbnpxayhg3Tl6fee+B+UjGhvL/LMbmRplUK4nYn+u/YBd7s8
         GZHbgfvuj7tf8fjc2yci/DDnTmG1iutOKW973pUw0C2SEHf1t6OOulyItMhpFP29kPgu
         d18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAiZDfyravkgmTU87XNbWaKqoZ4BUrbWmy/iiYcxWto=;
        b=KYnl+bxgHSEAEo5ZA8rWJy8DBU4ov0Y9YFJWAl6qVadg+anURuiIf+C790jI6pXC9L
         AY+hFiEMHddouuNPf29UNPZ7dLznfZf/QZ3YKPm2GzK6mc8KoaCqlihM8MF3padnJPj6
         nCdFp66zf7BM+3G9aeAqLMchv8SisiWbyumieL5F14UiYCiScszuMghZNWz+Oitnvinj
         3wiKXOf4oTDyy+PjxyvvLw/gsxywBpure/2Y7t7sy5LHyangV0ts2w5RPa3ZqvINZUn6
         MnUIVH44E1Obw5f/KtfNnY7euJoGLZx42gE8IAAZdAmOfltN8G+NM9OsMWGri3n1iMlS
         op2Q==
X-Gm-Message-State: APjAAAX3988T0kbHylYcJuq8tsjuUmD2vXQl1FNl+MzrFy7JuSKjqA+o
        oTk/MUU/VCgN41DV9WX0J9d68qNB
X-Google-Smtp-Source: APXvYqz/teUf8NXgDf9mVd7UXe4/RCtN4XPqDaRsHXA3Fudco4wSXgxR9WN64LjOnYpq4OGEOIbQyw==
X-Received: by 2002:a17:902:9a44:: with SMTP id x4mr11776799plv.127.1571860958377;
        Wed, 23 Oct 2019 13:02:38 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm10593598pfy.43.2019.10.23.13.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:02:37 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 00/15] software node: add support for reference properties
Date:   Wed, 23 Oct 2019 13:02:18 -0700
Message-Id: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

These series implement "references" properties for software nodes as true
properties, instead of managing them completely separately.

The first 10 patches are generic cleanups and consolidation and
unification of the existing code; patch #11 implements moving of small
properties inline when copying property entries; patch #12 implements
PROPERTY_ENTRY_REF() and friends; patch #13 converts the user of
references to the property syntax, and patch #14 removes the remains of
references as entities that are managed separately.

Patch #15 adds unit tests to verify that the handling of property
entries is correct.

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

Dmitry Torokhov (15):
  software node: remove DEV_PROP_MAX
  software node: introduce PROPERTY_ENTRY_ARRAY_XXX_LEN()
  efi/apple-properties: use PROPERTY_ENTRY_U8_ARRAY_LEN
  software node: mark internal macros with double underscores
  software node: clean up property_copy_string_array()
  software node: get rid of property_set_pointer()
  software node: remove property_entry_read_uNN_array functions
  software node: unify PROPERTY_ENTRY_XXX macros
  software node: simplify property_entry_read_string_array()
  software node: rename is_array to is_inline
  software node: move small properties inline when copying
  software node: implement reference properties
  platform/x86: intel_cht_int33fe: use inline reference properties
  software node: remove separate handling of references
  software node: add basic tests for property entries

 drivers/base/swnode.c                         | 263 ++++------
 drivers/base/test/Makefile                    |   2 +
 drivers/base/test/property-entry-test.c       | 472 ++++++++++++++++++
 drivers/firmware/efi/apple-properties.c       |  18 +-
 .../platform/x86/intel_cht_int33fe_typec.c    |  81 +--
 include/linux/property.h                      | 178 +++----
 6 files changed, 702 insertions(+), 312 deletions(-)
 create mode 100644 drivers/base/test/property-entry-test.c

-- 
2.23.0.866.gb869b98d4c-goog

