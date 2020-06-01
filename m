Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C691EA758
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jun 2020 17:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgFAPvi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Jun 2020 11:51:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35835 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPvi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jun 2020 11:51:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id 69so8384875otv.2;
        Mon, 01 Jun 2020 08:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Cfw4YeD4Ny1INfDH1tv7NS/t1naJ0UW1Mxkm3+KOoXg=;
        b=uSOOrHZwnMyrpwyrYlHIofsbkbACd2b4tQZfYf6upyeBUsin1samK/Ge1ezA9N9y8L
         IMC+S8PHVdhSXkI2YBD9NA6DmJr/IOiT98w0rRSK1gIofo/FDTR3enXg8S0gYkShlWrC
         YH2RwyvtP0ldPiG1B7fyvcdxhVQbClN0YnlvQO0yzcquliwG4WCk0nlhMIkbxyh3hX8S
         K0j9z+haZIVr88y2n5vf7CyldQj7Oza9rCb9aPwcRQMgpC78HbQofess2o+r9xNQcnaB
         H11hPpLwDhbDfx8lMULwvXG8BY3fsruU48rLaPaSlMOLFddPaeyGL5eO4iZLOoYnLuH3
         651Q==
X-Gm-Message-State: AOAM531WhWMozwIRNMaHIID7VWF1tRFUevcx3eOoMIK9xyycroEUcbgs
        pTxtiZEy6AEagjdrSRwW5dVfIagiQxc89sqBbgg=
X-Google-Smtp-Source: ABdhPJxJ1Ku4wZm+4rfvD//MpGp4sgWJodrIZZ7i8Be7HgDnEEAtK166KrEN50hB4e9S889rf6TZFAmWP1L2i8YdzZ8=
X-Received: by 2002:a9d:6c0f:: with SMTP id f15mr16501345otq.118.1591026697401;
 Mon, 01 Jun 2020 08:51:37 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Jun 2020 17:51:26 +0200
Message-ID: <CAJZ5v0iimLWRbrwFy51oC-ZGhuVax5zfcXy2O+O-vchjyY3i-Q@mail.gmail.com>
Subject: [GIT PULL] PNP update for v5.8-rc1
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
 pnp-5.8-rc1

with top-most commit 9361797c7696874a1136442b5ee69c62b0e54738

 PNPBIOS: Replace zero-length array with flexible-array

on top of commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8

 Linux 5.7-rc5

to receive a PNP update for 5.8-rc1.

This replaces a zero-length array with a flexible-array (Gustavo
A. R. Silva).

Thanks!


---------------

Gustavo A. R. Silva (1):
      PNPBIOS: Replace zero-length array with flexible-array

---------------

 drivers/pnp/pnpbios/pnpbios.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
