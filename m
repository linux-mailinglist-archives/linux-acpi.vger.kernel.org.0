Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6AF768A24
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Jul 2023 04:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjGaCuR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 30 Jul 2023 22:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaCuR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 30 Jul 2023 22:50:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA8AE46
        for <linux-acpi@vger.kernel.org>; Sun, 30 Jul 2023 19:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 058FF60DF6
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jul 2023 02:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6F5C433C7;
        Mon, 31 Jul 2023 02:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690771815;
        bh=9F83NESB3MsIpi/NJyZ5owEqyRAMOlnpJSpxuAARug0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cMx0jp3PfWAAB7+N1nsNtQ49L4iExn3escATkicUDxxD54IL76Gmk/hI4VKCE4mUi
         h0YtOkMltRG9YVC41m7IaAMuNpo6VqXP35GeiIkBq0/GhjCKkAwBWTwgDJX+hkRFsQ
         wNF27kljoi7s8gNCE+JlIweTgckCLaQM55UKSBv5Lhk9x/KouNtOx2NgVQpmveXRGl
         m+CUFmZ5Cz1rUsvq3CCHkZxBtIcKjk//V0MBAuX3EwJbR8/pJNXtkHjBrYFK3/hrmz
         RMn+VwjJOTzpGUzQ+vNsJBENzSKEX9yFPND1S9AJgkRb8Eh2uT5yXwY02aOFOPUpGl
         hhsvHsHhsQZGQ==
Date:   Mon, 31 Jul 2023 10:50:11 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     rafael@kernel.org, lenb@kernel.org, bleung@chromium.org,
        groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-acpi@vger.kernel.org, guillaume.tucker@collabora.com,
        denys.f@collabora.com, ricardo.canuelo@collabora.com,
        usama.anjum@collabora.com
Subject: Re: [PATCH v2] platform/chrome: chromeos_acpi: support official HID
 GOOG0016
Message-ID: <ZMchYw19KmfcChGK@google.com>
References: <20230728065438.4026629-1-tzungbi@kernel.org>
 <CABXOdTca9hmjWXNATeSkhZAV1PXh1ppt6ENEV23xUpO86ogu_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXOdTca9hmjWXNATeSkhZAV1PXh1ppt6ENEV23xUpO86ogu_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 28, 2023 at 08:03:50AM -0700, Guenter Roeck wrote:
> On Thu, Jul 27, 2023 at 11:55 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > --- a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> > +++ b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> > @@ -1,4 +1,4 @@
> > -What:          /sys/bus/platform/devices/GGL0001:*/BINF.2
> > +What:          /sys/bus/platform/devices/GOOG0016:*/BINF.2
> 
> Doesn't the description mean that both sysfs directories might be seen
> in the field ?
> If so, replacing one with the other would be wrong.

Fix it in v3
(https://patchwork.kernel.org/project/chrome-platform/patch/20230731024214.908235-1-tzungbi@kernel.org/)
by appending a new line for "GOOG0016".
