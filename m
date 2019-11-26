Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC597109E74
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Nov 2019 14:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfKZNCR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Nov 2019 08:02:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36506 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfKZNCQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Nov 2019 08:02:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id f10so15807991oto.3;
        Tue, 26 Nov 2019 05:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=a6t3Tx5m+5tPyVolI/88uOygfkVbfUzjcJAhGnLCRII=;
        b=NDLrzdXpX4xAwUab28sA+j/QRIiDChcrhGsj9j1epMhyViU7ZTmBlSxG/zqWwymzwe
         UhrfdY0MTzLbnPOoVGR+hQO8ADqpO6sUuPH8gYRnzO9NOV0xu2dTdlyKONzUUw6XwEfk
         +WwIkQXhEwFqy5aTBo22NZqdXPDm7eYey15KiUrdtowo9gZqBorYe+gFoiewwXvrIUru
         KEB1WgnZW9BY+wluAYwJVYcQFmSrlta/6WoxD+crCMIbMqNJEWXYzMMvTc7J+Tn0jHT3
         Xx8k/1icKpgmzo7ZDyP84OruJUiJHy/IgQonXq5l085lmtuszf9P5pnehVGANmWz/278
         h3aA==
X-Gm-Message-State: APjAAAWJJXqfzbi/MUfRXQ6Trkb+o8kkxOnopSW4aSQbnAQfVtgQ55z8
        ueWKl8Q/Ayg8d4AgEGqdSzKDa+a+HihXEvKJMlc=
X-Google-Smtp-Source: APXvYqymvChDyM/t6YfoooZrIA2KvQa7JtHGhT56HIprePtkPtxG4n7ZFHHds0oUpiT7Qc1ZFurcTBenbhdMHL771wE=
X-Received: by 2002:a9d:6b91:: with SMTP id b17mr2168488otq.189.1574773334221;
 Tue, 26 Nov 2019 05:02:14 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Nov 2019 14:02:03 +0100
Message-ID: <CAJZ5v0ih9pkWuMkDyKxG3rRnwELtNt+zz9JRudOgEAjS=XZawA@mail.gmail.com>
Subject: [GIT PULL] Device properties framework updates for v5.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.5-rc1

with top-most commit 1afc14032e54a7e6c38304dc9a6bda1b6416f2b7

 software node: simplify property_entry_read_string_array()

on top of commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce

 Linux 5.4-rc2

to receive device properties framework updates for 5.5-rc1.

These add support for printing fwnode names using a new conversion
specifier "%pfw" (Sakari Ailus), clean up the software node and
efi/apple-properties code in preparation for improved software node
reference properties handling (Dmitry Torokhov) and fix the struct
fwnode_operations description (Heikki Krogerus).

There is a merge conflict between this and the printk tree (affecting
checkpatch.pl) that has been addressed by the appended patch from
Stephen in linux-next.

Thanks!


---------------

Dmitry Torokhov (9):
      software node: remove DEV_PROP_MAX
      software node: introduce PROPERTY_ENTRY_XXX_ARRAY_LEN()
      efi/apple-properties: use PROPERTY_ENTRY_U8_ARRAY_LEN
      software node: mark internal macros with double underscores
      software node: clean up property_copy_string_array()
      software node: get rid of property_set_pointer()
      software node: remove property_entry_read_uNN_array functions
      software node: unify PROPERTY_ENTRY_XXX macros
      software node: simplify property_entry_read_string_array()

Heikki Krogerus (1):
      device property: Fix the description of struct fwnode_operations

Sakari Ailus (12):
      software node: Get reference to parent swnode in get_parent op
      software node: Make argument to to_software_node const
      device property: Move fwnode_get_parent() up
      device property: Add functions for accessing node's parents
      device property: Add fwnode_get_name for returning the name of a node
      device property: Add a function to obtain a node's prefix
      lib/vsprintf: Remove support for %pF and %pf in favour of %pS and %ps
      lib/vsprintf: Add a note on re-using %pf or %pF
      lib/vsprintf: Make use of fwnode API to obtain node names and separators
      lib/vsprintf: OF nodes are first and foremost, struct device_nodes
      lib/vsprintf: Add %pfw conversion specifier for printing fwnode names
      lib/test_printf: Add tests for %pfw printk modifier

---------------

 Documentation/core-api/printk-formats.rst |  34 ++--
 drivers/acpi/property.c                   |  48 ++++++
 drivers/base/property.c                   |  83 +++++++++-
 drivers/base/swnode.c                     | 258 ++++++++++--------------------
 drivers/firmware/efi/apple-properties.c   |  18 +--
 drivers/of/property.c                     |  16 ++
 include/linux/fwnode.h                    |  10 +-
 include/linux/property.h                  | 106 ++++++------
 lib/test_printf.c                         |  32 ++++
 lib/vsprintf.c                            |  93 ++++++-----
 scripts/checkpatch.pl                     |   9 +-
 11 files changed, 414 insertions(+), 293 deletions(-)


---------------

diff --cc scripts/checkpatch.pl
index 4b40445938dc,3d1f08fa091c..000000000000
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@@ -6019,10 -6020,13 +6020,13 @@@ sub process
                  my $fmt = get_quoted_string($lines[$count - 1],
raw_line($count, 0));
                  $fmt =~ s/%%//g;

-                 while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
+                 while ($fmt =~ /(\%[\*\d\.]*p(\w)(\w*))/g) {
                      $specifier = $1;
                      $extension = $2;
-                     if ($extension !~ /[SsBKRraEehMmIiUDdgVCbGNOxt]/) {
+                     $qualifier = $3;
 -                    if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxtf]/ ||
++                    if ($extension !~ /[SsBKRraEehMmIiUDdgVCbGNOxtf]/ ||
+                         ($extension eq "f" &&
+                          defined $qualifier && $qualifier !~ /^w/)) {
                          $bad_specifier = $specifier;
                          last;
                      }
