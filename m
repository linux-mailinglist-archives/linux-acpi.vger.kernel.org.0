Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892DF3A4676
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Jun 2021 18:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhFKQa3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Jun 2021 12:30:29 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:37623 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhFKQa2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jun 2021 12:30:28 -0400
Received: by mail-oi1-f180.google.com with SMTP id h9so6381181oih.4
        for <linux-acpi@vger.kernel.org>; Fri, 11 Jun 2021 09:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WXIdRzS5H5MAfobhwh2B1mI1QQeBNzs9Ms3hgm3MmTQ=;
        b=bjiPUwE72n6GzZlEICPu6JBQSWQtCW79wC0Tpo/t9GoBf1oik+LN6ZL5K/keXlAFOM
         gOBUpfc4svEJtEvyT+zurKumWrC0fzXKcP4vs9Hn6Ksl5pK1f/oS5e6aY/rP6xegQpPR
         z74ZSwuAXvVVP9MvvnwGmJpDX2lAWtiLTl96QFJpI2vfvUg8/Pu0ngDra8dJY/BmFjda
         24yUPnV9m41ac0K5oHvTwK7dra1LNdMpqmEr9kOv5bG9Dix02JIPUdhRIm8MJKopZZ9k
         apfIwwwrM4r7z3FgDWMVUFIYFJ5BC3iZMdvPE9YOjMsBM7L/zLl0N7fVOO0oNr5nOn4M
         90EA==
X-Gm-Message-State: AOAM530iNpYKV4WCS8TJH441bzA91CbALjuHouHPeDGqVF0ARaLGDDk/
        sr1LCUQl8vtxMDdpnf+SRnz+a31Sm61BaELPUjc=
X-Google-Smtp-Source: ABdhPJzt+lGPPpAOUAFktef1kB2pICbUPKwO+dxZcFKeGqdgDytFT2T4pBhbaOvUOOwS58serYnX1dWBFFnUkWIdZ2k=
X-Received: by 2002:aca:b406:: with SMTP id d6mr3013182oif.71.1623428893869;
 Fri, 11 Jun 2021 09:28:13 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Jun 2021 18:28:03 +0200
Message-ID: <CAJZ5v0h+HG5eDcjBJKxNqnEbOKayG8A2wk337NmRio_OxurGEA@mail.gmail.com>
Subject: [GIT PULL] acpi-scan material for v5.14
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

The following commits:

23db673d7e51 ACPI: scan: initialize local variable to avoid garbage
being returned
b83e2b306736 ACPI: scan: Add function to fetch dependent of ACPI device
a9e10e587304 ACPI: scan: Extend acpi_walk_dep_device_list()
6d27975851b1 ACPI: scan: Rearrange dep_unmet initialization

are available for you to pull from from the git branch at:

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-scan

that is not going to be rebased before merging.

Thanks!
