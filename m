Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E036679AE98
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 01:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbjIKVSk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbjIKJwR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 05:52:17 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12BBCE6
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 02:52:12 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-45088c95591so1976552137.3
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 02:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694425932; x=1695030732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIn7ppfI5hUpZ9BWxWQzUJmi7tuPomUJZC2PQ3FzTQQ=;
        b=07YFJQkUeiL3lWFl7abLIGKxeKDPyLSlQvruWtuE0RXA3iHdEPmYRzO+dSTW1yls7P
         im38IXFacFuIQibFMVCGF/JdCcfW3gVvaehmubYhS3TwiLnxd7mmluFkj2P/PTie7skn
         q6eDMcNkYgzx6JalgZnSoCfqjxoSpOHs0ukqDQb62PrbF/YcVHB1qcfLsVPzahBvaWW0
         cf/SnTinPTP07H8iIT1tj//ruT97cgtd7Rj9/i8LHe6+DlpbgxXvER5McsJ9a1Hcjyhy
         KFI4TPEYhwJDQjO3/76fuF7/Hm2flaeOl1WHskRz+E8v/TbDxu7qFWyBEkIri98v4soq
         ZfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425932; x=1695030732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIn7ppfI5hUpZ9BWxWQzUJmi7tuPomUJZC2PQ3FzTQQ=;
        b=OiheQchZWYlfbNt0KVa3si10NeuMNr6WFDEZBMx34X6oo71ILu4OWzx9f15ZylfOYM
         4h22FchFgiZdgsN//hf7/IkHmZHPBJhuz+zTMw9sUxmk9b5W4bUo+PFT3gm6rDX1rZCH
         FK8ywG9J+iUqeZObm9m+MdU+FFCtWShWG1PYOJESEq4iHTyJjJAJm+gDyx0jr9Lq6/nF
         92qhiakbjn8ybFCidhe2ShugAzUg0uY/zvMZJ7rnvQbiyXLw1J0PpOVA2FpTyKbLZdXH
         2N7PtzOOLmES512GoGYJtzumRkKTVIamWfX8Wrj0AL4qEo56t0CDafwr2I2K0DKtJcec
         0rHg==
X-Gm-Message-State: AOJu0YzcymkjIpewe6q9FTcl9UoWvGHIiCfsr/S0O+H9c+6lBrLlzVrK
        B3PzPJ+B6tHfXap17tiXbhlYNr/6o4PyLj8MfpfJKSJpZK7jjgzPBGg=
X-Google-Smtp-Source: AGHT+IHibDNcC0W+t+sqyHgZd/i+fSeIzfiyJ4cjrCpSbO2UJ3YBbXCP+TDuS+qow+FJct3Pniq4ec1uXbAZUbmESNQ=
X-Received: by 2002:a67:e981:0:b0:44e:d6c3:51d6 with SMTP id
 b1-20020a67e981000000b0044ed6c351d6mr7589163vso.14.1694425932088; Mon, 11 Sep
 2023 02:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-4-hdegoede@redhat.com>
In-Reply-To: <20230909141816.58358-4-hdegoede@redhat.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Sep 2023 11:52:01 +0200
Message-ID: <CAMRc=MeErGNWcYmm=T8HXPUoYzOQwjsSZGh9w_ssTffk-ze_zA@mail.gmail.com>
Subject: Re: [PATCH 3/8] platform/x86: x86-android-tablets: Remove
 invalid_aei_gpiochip from Peaq C1010
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 9, 2023 at 4:18=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Remove the invalid_aei_gpiochip setting from the x86_dev_info
> for the Peaq C1010.
>
> This is no longer necessary since there now is a quirk to ignore
> the "dolby" button GPIO in gpiolib_acpi_quirks[] in
> drivers/gpio/gpiolib-acpi.c .
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
