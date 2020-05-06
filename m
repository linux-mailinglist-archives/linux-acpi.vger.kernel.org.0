Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E101C7947
	for <lists+linux-acpi@lfdr.de>; Wed,  6 May 2020 20:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgEFSVW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 May 2020 14:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgEFSVV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 May 2020 14:21:21 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96432C061A0F
        for <linux-acpi@vger.kernel.org>; Wed,  6 May 2020 11:21:21 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id s85so518853vks.11
        for <linux-acpi@vger.kernel.org>; Wed, 06 May 2020 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vPg4AVi+k3F+IpnTqL5EozyDUQaqheuuIk/pRIl8Ql0=;
        b=pbtNiXhUpyN5SBhvuWGaMFDqD6koTPadSKqkOOC5m2D0gvVK67BMqhb4DT19+FX4Vc
         /3R602qwhxMqOi5oejeVtH8lPdeFcbN0n411EIwAgksLQNi6d/8FfjjsxUxo8z4DlLV8
         rMxlXbC4qLsJG03iUxYy3CBSbUyik65Jo9ARcoytU00p7ZJUAgdfOY9Zx8XmQb6eeWJN
         sblV+AyHAKWGxayCYVJUbt2Eq+IG9y41FoBUI/kJiguGJsbdZy8jzJgId/Oee56FOFYq
         a/S6zVPPNfI037U+tnNOeQpIXULpJ5Xe7SM34sJgpo4JtltkOEoQNg9Cv/WZnyAqnJ46
         rn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vPg4AVi+k3F+IpnTqL5EozyDUQaqheuuIk/pRIl8Ql0=;
        b=Zqdxw65X4P+Ox5g1AIG8iZGxFEbrbxxfXMBnyHslXOX1gRjPWcg4IZDiz5QaC+8rHP
         VagHaf3jBghoozr5O5haBe09LKneeu3G3sPLYaPCy9vGfyls9PNZpDtDROMNKmieX0ab
         F86b+unx0Nlq5HVBIII5XmQNX3FFbLGPU+2ESmOzjqNHn8W6m8pL3o9aUHzHb0RC1lwC
         exJ+sWpI6amdNqqXC9eo9VR9ByDJLFkhpg7veZzHEHDlaqBltgOogYcTxD05GTBqNp90
         DwDJ7n//IhLk5S7vriVAjGLkxgk3lvdOo3V6O/R/f27A2taHmvyuZoz9/KcG5fkziQD6
         vT9g==
X-Gm-Message-State: AGi0PuZr7fIBA/FrUzx7pfjqNM+Q1lNBN3AunqwMOUhCVQDmdmiCuXCc
        RqlJfi5kOaWrsClW7XNoXR8j0yRz0Q0yKKRx2hEDIcBI
X-Google-Smtp-Source: APiQypLD/S7hT3cQEPL//CpJCKJDPKf2XOFsikT31YFN4MYGW+wtscm2kC89RW2AGhdOqSopigj5Wf3GuRN9tq9/vAc=
X-Received: by 2002:a1f:8fc1:: with SMTP id r184mr8336167vkd.12.1588789280081;
 Wed, 06 May 2020 11:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2dokvEdG5P5dso8+3vh7urX1FCFx4p+g-TiBH62+pMfuDKqA@mail.gmail.com>
In-Reply-To: <CAM2dokvEdG5P5dso8+3vh7urX1FCFx4p+g-TiBH62+pMfuDKqA@mail.gmail.com>
From:   Jaime Perez <19.jaime.91@gmail.com>
Date:   Wed, 6 May 2020 20:21:08 +0200
Message-ID: <CAM2doks5uTqmeV+f8ok4D=jCRRM=rEYUM_jdVHGmvToOZmcrWA@mail.gmail.com>
Subject: Fwd: Suspend
To:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,
I have not been able to suspend my pc since I used chromeOS. If I
press on suspend button, my pc seems to go to sleep, but when i press
power button or space bar, it goes to bios and makes a normal boot.

Thanks
