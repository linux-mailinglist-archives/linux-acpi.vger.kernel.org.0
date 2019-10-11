Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF2ABD4A86
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2019 01:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfJKXH0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 19:07:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44841 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfJKXH0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 19:07:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so2614219pgd.11;
        Fri, 11 Oct 2019 16:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oK3PBeetvr3vm8ZcG9YWRtzBHe8gB8wA9dfQ/fHXlfE=;
        b=jwIIyplbVvKCLEeeYP9DswqD71cfGjDM1KlGsu261MGqPdtjUxjGitJ+Z5F6NekInf
         1t6C5h3Ly+QIawO/7VTrDa0N0jqF3duYKTHALJgIuiIE79g6Gzhsv6hWA4j36lYJFhXB
         F+DXFCBvHWeCpPsJzJfMHvXg407krb98rmyqgN/MGa9kRSehbe4L8pa8mepSZJfzWoGp
         BBxF0NO9MD+j3OF20xIULwXuuHQdXUyS3OONu3XIAbcvMUd/rY8MP4GAfL0i8oitKNYi
         xHdp2dq/EPn0vafcD/l0UWvjJ0uqkrK74e7nLpn7hsnbizg3hFD7i18SddDeuB4qHY1e
         5fYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oK3PBeetvr3vm8ZcG9YWRtzBHe8gB8wA9dfQ/fHXlfE=;
        b=IDPxC56H5XDpcdvteaBk4tm2rvpgm0XnO1SgbnS8Sy3fsdCuAsLy6SpbZzae53gOsm
         NIrU/FiDweoAxVeUR0bLbshqXxeBGsVZaIy9L2cat0AL0x3LiF8NprESfwczgOohY8HA
         Qs8UrourhB4ii61Aqb+n33P522OdUCOlDdGdgXYhYuhS9rlgM//gcHtgSr5TPOzUaOpY
         Jrs5kllc6iHeeFEZ4V1uFb6joJXeaLwqXuI1faAWFUJuJqaXW54/VYv3wFnx9fnFxV+W
         v7NBZrLBaUOPDLSt7umllaE9443HrrVEB5trc1WdHlzdKT9ZnCEjCcty3BBSVLWVdWpf
         DgiA==
X-Gm-Message-State: APjAAAUxo2ShAvkC5e0znCcMFjo5CyNFcasprolSCLuZdoGrXLdLYcAi
        CpJ/jA33H/PHjdrV/kaOayH7tLjN
X-Google-Smtp-Source: APXvYqxA4xf9RehMosGcnsfqsnfDuOyco1oZUHNPm6LuZWHmbT+7QAZHLR5bgzPrEYJianzZQ8W6Ww==
X-Received: by 2002:a65:6817:: with SMTP id l23mr19166281pgt.338.1570835245387;
        Fri, 11 Oct 2019 16:07:25 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w2sm11529251pfn.57.2019.10.11.16.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:07:24 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 00/14] software node: add support for reference properties
Date:   Fri, 11 Oct 2019 16:07:07 -0700
Message-Id: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
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


Dmitry Torokhov (14):
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

 drivers/base/swnode.c                    | 266 ++++++++---------------
 drivers/firmware/efi/apple-properties.c  |  18 +-
 drivers/platform/x86/intel_cht_int33fe.c |  81 +++----
 include/linux/property.h                 | 177 +++++++--------
 4 files changed, 230 insertions(+), 312 deletions(-)

-- 
2.23.0.700.g56cf767bdb-goog

