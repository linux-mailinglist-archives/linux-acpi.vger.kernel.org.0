Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A64B22CAD4
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jul 2020 18:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGXQVA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jul 2020 12:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXQVA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2020 12:21:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3EAC0619D3;
        Fri, 24 Jul 2020 09:20:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a21so10536981ejj.10;
        Fri, 24 Jul 2020 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9fZAlfoscywDVonBU4GetzG1H5h8BHW6e/1a6Oe5dzA=;
        b=ise297L8h6DEJiSAGy2ZtGJhwPYaJqJ/2sxo66wsMAZ3SlEEfgCeZpRI04ocQBZ58c
         wqV9htzzWWmS+PYsQ6M5WSbNlsdQCkK4HFpWyT5Pel7OFHnERafl5PxcTSI71XJdYi74
         Wm2RccznstPnceCz5gk6LIlr0DHfMfimRM2ZQT8f3Wk9s4NLa//3AQ/JkM3+fXDvNuJ5
         orh+9iideNEFk+RMAR/xEJfWlaI+ggqmHc6VOkSPAm0utiYpY5KVisfmKi4LWQmvv3tX
         XeXTn+GaQHkSQi0Rkw1H00b0pD68yyOdl9OixZQmI5+iMSYRy2FtL5i204LxAbFR3hND
         48+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fZAlfoscywDVonBU4GetzG1H5h8BHW6e/1a6Oe5dzA=;
        b=iYcPVDkXrNlKWwESCwf2eyb88ShrvCih8pzdLqN/UPlm2KB78T/idNBA9LMscySRiO
         JphmT96CTDymNCwpPj8vceGRP2pq+IUlqrHx1ib66oKtj9YQHXSBsEIoNjQD0TsVtz3F
         iA7HrdScNN57eSTdIpIwjNxb3l4bYkDSnVonSbR7EzOq684j+aZvHWeOhv94gTEqZTjA
         rZa8rY2Icx1JhRzvhnEMSh83Znr9UvHYxLZAznUkMiOz37pnKiYYVRMvPCBee2zuqDiT
         yXUQt3OlS/XlZn6pTaO5BsX/Xk/hKL2ovKaSkjbpJzY6QwmJUYxTYdH9hqn4nIXVy/Sq
         jZeg==
X-Gm-Message-State: AOAM532xYLlFTx8kz3QTeuA1YYwa/KpgoCEgfp6yltgV6zMX/cA2N/NO
        XOPdSmY1mBXjfTujwjXPndA=
X-Google-Smtp-Source: ABdhPJz9f81w4lzxgtRGLQDmBXCpCYTFFo+F0l2G8ZKghfHQvHlmuO+ly+krhoidcODYDoOCvdMJ+g==
X-Received: by 2002:a17:906:dc12:: with SMTP id yy18mr9250481ejb.295.1595607658318;
        Fri, 24 Jul 2020 09:20:58 -0700 (PDT)
Received: from garrit-VirtualBox.fritz.box ([94.31.102.44])
        by smtp.gmail.com with ESMTPSA id o20sm937069ejr.64.2020.07.24.09.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 09:20:57 -0700 (PDT)
From:   Garrit Franke <garritfranke@gmail.com>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, trivial@kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, kernel-janitors@vger.kernel.org
Subject: 
Date:   Fri, 24 Jul 2020 18:20:50 +0200
Message-Id: <20200724162050.18077-1-garritfranke@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.21.2007241814450.2834@hadrien>
References: <alpine.DEB.2.21.2007241814450.2834@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks for the quick replies!

Sorry for the inconvenience. My git was set up incorrectly.

Regards,
Garrit


