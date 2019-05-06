Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450CB148C2
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2019 13:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEFLQO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 May 2019 07:16:14 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39438 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfEFLQO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 May 2019 07:16:14 -0400
Received: by mail-oi1-f193.google.com with SMTP id x16so3337468oic.6;
        Mon, 06 May 2019 04:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cJyYuADfEWn6fMmGuvdFVfwMOt9JIo6FdLSYJFZv93U=;
        b=sFcXu5DBH4DZIQNKcwlTfi3IXSghmnsyIGfO3p6Cmz5FhlOiDKweetNAF2p0bMLb90
         MGWpzeEyY2CykmGwZqCqVcRDPSDHtidIj5Dc9HLH2fTjpuXr8/JIF+hcb4Xp2RBh+WH3
         yzDAvdYwPX+7nTYwjBY8h4rNi1NrwBCrYEHi/7KBjhe+Z68udy0/9JCAAu84CIW25Yg9
         vSW7UVCnVhDLL5g5TQgGbh20YyViImp/bv7bR9BSPm60DQQaotSOOXNGltxw0157wvVc
         +FpOICGvQMrpsPKcJeWrYiDYMqFIdI4feZNfoP96Y1tQYaVgYDgdZhw8BedBdOKASiZL
         Y5ZQ==
X-Gm-Message-State: APjAAAVY9zBOdHxEcQqsXIUGXeXCN6VEhl+48UzkKZkt6kw0hSy3+tgj
        FJA7oSOwHphnjeZuze7DSwHze1EiaVWjkOl1zkmwG2rW
X-Google-Smtp-Source: APXvYqxN3hKZvpklY46oOagbJEr8nc5+hFaglZLO3u+BsKoPOffBozEeNN1VQHV9n7k8AUQewslaSSvkUGEMDkndW48=
X-Received: by 2002:aca:ba82:: with SMTP id k124mr822524oif.110.1557141373079;
 Mon, 06 May 2019 04:16:13 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 May 2019 13:16:02 +0200
Message-ID: <CAJZ5v0jx12=bmcDaVkgd1=mocwPQ2MwMNHOE6KiTSyS+CdhRyQ@mail.gmail.com>
Subject: [GIT PULL] Device properties framework updates for v5.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.2-rc1

with top-most commit 23583f7795025e3c783b680d906509366b0906ad

 ACPI / property: fix handling of data_nodes in acpi_get_next_subnode()

on top of commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2

 Linux 5.1-rc5

to receive device properties framework updates for 5.2-rc1.

These fix the handling of data nodes in the ACPI properties support
code, add a new helper for endpoint lookup in property graphs and
restore a comment inadvertently removed by one of previous changes.

Specifics:

 - Fix the handling of data nodes in the ACPI properties support
   code for devices with child devices and hierarchical _DSD
   properties (Pierre-Louis Bossart).

 - Add fwnode_graph_get_endpoint_by_id() helper for endpoint lookup
   in device property graphs (Sakari Ailus).

 - Restore the _DSD data subnodes GUID comment inadvertently removed
   by one of previous changes (Shunyong Yang).

Thanks!


---------------

Pierre-Louis Bossart (1):
      ACPI / property: fix handling of data_nodes in acpi_get_next_subnode()

Sakari Ailus (1):
      device property: Add fwnode_graph_get_endpoint_by_id()

Shunyong Yang (1):
      ACPI: property: restore _DSD data subnodes GUID comment

---------------

 drivers/acpi/property.c  |  9 ++++++
 drivers/base/property.c  | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h | 18 ++++++++++++
 3 files changed, 102 insertions(+)
