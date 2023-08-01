Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C8D76C6FE
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Aug 2023 09:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjHBHf4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Aug 2023 03:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjHBHfy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Aug 2023 03:35:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC6D1702
        for <linux-acpi@vger.kernel.org>; Wed,  2 Aug 2023 00:35:26 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5222bc91838so9534925a12.0
        for <linux-acpi@vger.kernel.org>; Wed, 02 Aug 2023 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690961725; x=1691566525;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=whzrFiFDXsxlOAugWLGBbpaxuv1pZIzaI72w9ONk2co=;
        b=VMhdersl41V5+LiCY+XaKEQoOPKdsRq+ydlrbXdNAfX456uEGheeaRnwU+DhDcQh4f
         wz9ZIcRGQuuixANTzeVLt2GJ3t278GRAIEn9KM2RZHR/6OKF5a8dYkV1BnUOmEsABmrO
         rH9GHhUhncwgGoB8cV9bFd2dKxNjXuiUu1Ch/vAbg9tFcknJrGek4/JYq4CwPHgnXeNK
         UZny4EJXlaDgq2UkzOcN7Wp3nLQuNYze7/gLeR8ggzf/ZPCJvUjIVyCkVPwyufKsdT9N
         lyh9t1+k/qZk/RymxTMKD9Lhrw/kwRZdjofA5SvuTKlj+GGMk+Fb/nbdYw/3q5eZqNqB
         eKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690961725; x=1691566525;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whzrFiFDXsxlOAugWLGBbpaxuv1pZIzaI72w9ONk2co=;
        b=JvGAT2T9qz9Q23Jx60Ln2WtgmrWliYVw3AHUl+zgD9Nnij9bKnmlMQMxsAxwSDdh8F
         YbAtQ2TavZdgSj5/m3K2fwwBNdCvO0NuElL9b4jR39Ha9tzAJ0uLIgijTRy3+hcXiVhg
         PT1WWjrk6HDCUItsy9qPI8oi1JVk1vMoD6i3G1T/WiWXpRc0cukcS5nC+5BtAHqm/0T+
         fuuAr9krn8SW8eH0ssvoTFg/8i5DBcc3LlofG7oLwJRl1RnmqJOV7inyreyAJJSWHJSo
         9xpcyImn9nulwc9AvoWJk/yNfxOKGUFiPRhqHVSQoMPJ5g9RB46kffYPvTHpunmBhL61
         Aq+A==
X-Gm-Message-State: ABy/qLZpxo+RUfPmIXHPNP3aCCPmPAeFvXTkco47RgzyN+BN6TC/lpV4
        wCw6A6Z83HJ2jRpX1YMzKPeDjw==
X-Google-Smtp-Source: APBJJlFxv46Yn6HfI393SWv6JgHv2CwW0FKGrKUDqw1nyEfyyadbYoswq2hAmTFP/jO87HYyAsmDuQ==
X-Received: by 2002:a17:907:b0c:b0:997:d627:263a with SMTP id h12-20020a1709070b0c00b00997d627263amr4022193ejl.67.1690961725300;
        Wed, 02 Aug 2023 00:35:25 -0700 (PDT)
Received: from localhost (h3221.n1.ips.mtn.co.ug. [41.210.178.33])
        by smtp.gmail.com with ESMTPSA id gl13-20020a170906e0cd00b00982d0563b11sm8615511ejb.197.2023.08.02.00.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:35:24 -0700 (PDT)
Date:   Tue, 1 Aug 2023 10:45:20 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-acpi@vger.kernel.org
Subject: [bug report] PNP: convert resource options to single linked list
Message-ID: <63ae790c-ca93-456f-bb15-6fd330f1d6ca@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[ This is obviously ancient code, but maybe you could still take a
  look? -dan ]

Hello Bjorn Helgaas,

The patch 1f32ca31e740: "PNP: convert resource options to single
linked list" from Jun 27, 2008 (linux-next), leads to the following
Smatch static checker warning:

	drivers/pnp/quirks.c:193 quirk_add_irq_optional_dependent_sets()
	warn: list_entry() does not return NULL 'new_option'

drivers/pnp/quirks.c
    180 static void quirk_add_irq_optional_dependent_sets(struct pnp_dev *dev)
    181 {
    182         struct pnp_option *new_option;
    183         unsigned int num_sets, i, set;
    184         struct pnp_irq *irq;
    185 
    186         num_sets = dev->num_dependent_sets;
    187         for (i = 0; i < num_sets; i++) {
    188                 new_option = pnp_clone_dependent_set(dev, i);
    189                 if (!new_option)
    190                         return;
    191 
    192                 set = pnp_option_set(new_option);
--> 193                 while (new_option && pnp_option_set(new_option) == set) {

The new_option part of this condition is always non-NULL.  I think
eventually we will call list_entry() on the list head so we end up
reading from invalid memory.

    194                         if (new_option->type == IORESOURCE_IRQ) {
    195                                 irq = &new_option->u.irq;
    196                                 irq->flags |= IORESOURCE_IRQ_OPTIONAL;
    197                         }
    198                         dbg_pnp_show_option(dev, new_option);
    199                         new_option = list_entry(new_option->list.next,
    200                                                 struct pnp_option, list);
    201                 }
    202 
    203                 dev_info(&dev->dev, "added dependent option set %d (same as "
    204                          "set %d except IRQ optional)\n", set, i);
    205         }
    206 }

regards,
dan carpenter
