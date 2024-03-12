Return-Path: <linux-acpi+bounces-4289-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D96EC879CCD
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 21:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE89B21E8F
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ADB142906;
	Tue, 12 Mar 2024 20:24:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F511386AA
	for <linux-acpi@vger.kernel.org>; Tue, 12 Mar 2024 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275042; cv=none; b=BPHt7+ugx+FviYtMD2v8BVevnnL7i4axnGEZnMZAIR3FT8Zr+neBcaGcobOpx4j05Ilqpbptklvh7s3e32NrETyusXNFlxK82ku9TBu9LfgDLFFqx630nZxtrm+YD3fqGzOe5VJVa9dqkV6vZxhd3BLqT8oLLYJWBP/Tt1DW8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275042; c=relaxed/simple;
	bh=7yrYz8Jd84avxwwvKvpLx6/n4wISU6/tlBmE+LUbleQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrcrbqUs7Fsg1Zb4w9cYWqdpBLAcpKGe7nnPXKxzVwl64FAYFALzjrBVvIPeOtk+OoNmfifG4BHVf2CZ6owMluGu3MGMeIbeFP6O/L+4YYKOkkpN+cO1sswtm9DphwK9mzqLzFzwF8fvd6zgY67jyrzCGsU4KvlxKufuIva9xJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a1d6820280so32745eaf.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Mar 2024 13:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710275040; x=1710879840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1fjQAcsAfVC+cpt+ZWAG0R8eCK2otgE3dPkRNnrDus=;
        b=NCcuG3LP6efeOLHR67xi4oWbkbI94MdQnKn750r9pR1SGyP/TIU0UEGRn/pPHMTeBE
         BqqEgIcwbOVjqs8Iet5C03VclWog5rrZ+T8vTqW4+37nQPs51NX1ORTnMsyiOJ4TjTaF
         +QEBxGgreUkpc0owp9OzgtEvccJ5uYI8BAp8zBjU+Z9NzhFHX1NZGbtLEEuKAdKme2ey
         tOpaIxcGULFl1P3uqhbroaTpaL0c/FLJbGAVvMSdyBYlW/RABiuU8roelHDDSRaKYcl7
         wCiL8sseK/b34vxegon2rUkoAsnZQeDs2OTqRbHp6qC0r9CTNMX9moVRJgOvUkr31S69
         49Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUFyFADNpGQwtdcqmWvDsSWwN6XcMg/otF7w2w5iXgu58KHoLMhTOAhGjnqv+xo2jHiB/p9JWXYML7ylepl10I8lri0R6aAXpFfKQ==
X-Gm-Message-State: AOJu0YzXE5acI1EhFUoEuq8Bl21r2TFC46RjlRIvSmMN+LBmcbAxc7ki
	krMgi7sW6nxMu7rMXPah2zrXe3+TVeN2Yc/nfF1Q8MbXm9JCWX1ghGV7xwV7/P9OOJSFWiNRTIM
	JOM8DQvatuEL+f4xmrrGc7PJnZ71OeMM7
X-Google-Smtp-Source: AGHT+IF6ChE7pC33q+eFZ0v1Ny+1CwfnugDSz1EQx6j5HGSahb27igHDRG5T++nqBsbwAEm0Bv2zscp18bFrHjka4/I=
X-Received: by 2002:a05:6870:ac0d:b0:220:c9cd:b2b9 with SMTP id
 kw13-20020a056870ac0d00b00220c9cdb2b9mr10760054oab.4.1710275040067; Tue, 12
 Mar 2024 13:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311101658.2343816-1-cezary.rojewski@intel.com> <20240311101658.2343816-4-cezary.rojewski@intel.com>
In-Reply-To: <20240311101658.2343816-4-cezary.rojewski@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Mar 2024 21:23:48 +0100
Message-ID: <CAJZ5v0hJXonkKjfpnYwM_sSJZcacbZ4G2yE=dqJ01kAoPQ0WKA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] ACPI: NHLT: Drop redundant types
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, 
	amadeuszx.slawinski@linux.intel.com, pierre-louis.bossart@linux.intel.com, 
	andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:15=E2=80=AFAM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> There are no users for the duplicated NHLT table components.
>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>

This also needs to point to the upstream ACPICA pull request and
commit corresponding to it.

> ---
>  include/acpi/actbl2.h | 254 ------------------------------------------
>  1 file changed, 254 deletions(-)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 8030a1743100..31a716a74340 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -1887,260 +1887,6 @@ struct nfit_device_handle {
>  #define ACPI_NFIT_GET_NODE_ID(handle) \
>         (((handle) & ACPI_NFIT_NODE_ID_MASK)        >> ACPI_NFIT_NODE_ID_=
OFFSET)
>
> -/***********************************************************************=
********
> - *
> - * NHLT - Non HD Audio Link Table
> - *
> - * Conforms to: Intel Smart Sound Technology NHLT Specification
> - * Version 0.8.1, January 2020.
> - *
> - ***********************************************************************=
*******/
> -
> -/* Main table */
> -
> -struct acpi_table_nhlt {
> -       struct acpi_table_header header;        /* Common ACPI table head=
er */
> -       u8 endpoint_count;
> -};
> -
> -struct acpi_nhlt_endpoint {
> -       u32 descriptor_length;
> -       u8 link_type;
> -       u8 instance_id;
> -       u16 vendor_id;
> -       u16 device_id;
> -       u16 revision_id;
> -       u32 subsystem_id;
> -       u8 device_type;
> -       u8 direction;
> -       u8 virtual_bus_id;
> -};
> -
> -/* Types for link_type field above */
> -
> -#define ACPI_NHLT_RESERVED_HD_AUDIO         0
> -#define ACPI_NHLT_RESERVED_DSP              1
> -#define ACPI_NHLT_PDM                       2
> -#define ACPI_NHLT_SSP                       3
> -#define ACPI_NHLT_RESERVED_SLIMBUS          4
> -#define ACPI_NHLT_RESERVED_SOUNDWIRE        5
> -#define ACPI_NHLT_TYPE_RESERVED             6  /* 6 and above are reserv=
ed */
> -
> -/* All other values above are reserved */
> -
> -/* Values for device_id field above */
> -
> -#define ACPI_NHLT_PDM_DMIC                  0xAE20
> -#define ACPI_NHLT_BT_SIDEBAND               0xAE30
> -#define ACPI_NHLT_I2S_TDM_CODECS            0xAE23
> -
> -/* Values for device_type field above */
> -
> -/* SSP Link */
> -
> -#define ACPI_NHLT_LINK_BT_SIDEBAND          0
> -#define ACPI_NHLT_LINK_FM                   1
> -#define ACPI_NHLT_LINK_MODEM                2
> -/* 3 is reserved */
> -#define ACPI_NHLT_LINK_SSP_ANALOG_CODEC     4
> -
> -/* PDM Link */
> -
> -#define ACPI_NHLT_PDM_ON_CAVS_1P8           0
> -#define ACPI_NHLT_PDM_ON_CAVS_1P5           1
> -
> -/* Values for Direction field above */
> -
> -#define ACPI_NHLT_DIR_RENDER                0
> -#define ACPI_NHLT_DIR_CAPTURE               1
> -#define ACPI_NHLT_DIR_RENDER_LOOPBACK       2
> -#define ACPI_NHLT_DIR_RENDER_FEEDBACK       3
> -#define ACPI_NHLT_DIR_RESERVED              4  /* 4 and above are reserv=
ed */
> -
> -struct acpi_nhlt_device_specific_config {
> -       u32 capabilities_size;
> -       u8 virtual_slot;
> -       u8 config_type;
> -};
> -
> -struct acpi_nhlt_device_specific_config_a {
> -       u32 capabilities_size;
> -       u8 virtual_slot;
> -       u8 config_type;
> -       u8 array_type;
> -};
> -
> -/* Values for Config Type above */
> -
> -#define ACPI_NHLT_CONFIG_TYPE_GENERIC              0x00
> -#define ACPI_NHLT_CONFIG_TYPE_MIC_ARRAY            0x01
> -#define ACPI_NHLT_CONFIG_TYPE_RENDER_FEEDBACK      0x03
> -#define ACPI_NHLT_CONFIG_TYPE_RESERVED             0x04        /* 4 and =
above are reserved */
> -
> -struct acpi_nhlt_device_specific_config_b {
> -       u32 capabilities_size;
> -};
> -
> -struct acpi_nhlt_device_specific_config_c {
> -       u32 capabilities_size;
> -       u8 virtual_slot;
> -};
> -
> -struct acpi_nhlt_render_device_specific_config {
> -       u32 capabilities_size;
> -       u8 virtual_slot;
> -};
> -
> -struct acpi_nhlt_wave_extensible {
> -       u16 format_tag;
> -       u16 channel_count;
> -       u32 samples_per_sec;
> -       u32 avg_bytes_per_sec;
> -       u16 block_align;
> -       u16 bits_per_sample;
> -       u16 extra_format_size;
> -       u16 valid_bits_per_sample;
> -       u32 channel_mask;
> -       u8 sub_format_guid[16];
> -};
> -
> -/* Values for channel_mask above */
> -
> -#define ACPI_NHLT_SPKR_FRONT_LEFT             0x1
> -#define ACPI_NHLT_SPKR_FRONT_RIGHT            0x2
> -#define ACPI_NHLT_SPKR_FRONT_CENTER           0x4
> -#define ACPI_NHLT_SPKR_LOW_FREQ               0x8
> -#define ACPI_NHLT_SPKR_BACK_LEFT              0x10
> -#define ACPI_NHLT_SPKR_BACK_RIGHT             0x20
> -#define ACPI_NHLT_SPKR_FRONT_LEFT_OF_CENTER   0x40
> -#define ACPI_NHLT_SPKR_FRONT_RIGHT_OF_CENTER  0x80
> -#define ACPI_NHLT_SPKR_BACK_CENTER            0x100
> -#define ACPI_NHLT_SPKR_SIDE_LEFT              0x200
> -#define ACPI_NHLT_SPKR_SIDE_RIGHT             0x400
> -#define ACPI_NHLT_SPKR_TOP_CENTER             0x800
> -#define ACPI_NHLT_SPKR_TOP_FRONT_LEFT         0x1000
> -#define ACPI_NHLT_SPKR_TOP_FRONT_CENTER       0x2000
> -#define ACPI_NHLT_SPKR_TOP_FRONT_RIGHT        0x4000
> -#define ACPI_NHLT_SPKR_TOP_BACK_LEFT          0x8000
> -#define ACPI_NHLT_SPKR_TOP_BACK_CENTER        0x10000
> -#define ACPI_NHLT_SPKR_TOP_BACK_RIGHT         0x20000
> -
> -struct acpi_nhlt_format_config {
> -       struct acpi_nhlt_wave_extensible format;
> -       u32 capability_size;
> -       u8 capabilities[];
> -};
> -
> -struct acpi_nhlt_formats_config {
> -       u8 formats_count;
> -};
> -
> -struct acpi_nhlt_device_specific_hdr {
> -       u8 virtual_slot;
> -       u8 config_type;
> -};
> -
> -/* Types for config_type above */
> -
> -#define ACPI_NHLT_GENERIC                   0
> -#define ACPI_NHLT_MIC                       1
> -#define ACPI_NHLT_RENDER                    3
> -
> -struct acpi_nhlt_mic_device_specific_config {
> -       struct acpi_nhlt_device_specific_hdr device_config;
> -       u8 array_type_ext;
> -};
> -
> -/* Values for array_type_ext above */
> -
> -#define ACPI_NHLT_ARRAY_TYPE_RESERVED               0x09       /* 9 and =
below are reserved */
> -#define ACPI_NHLT_SMALL_LINEAR_2ELEMENT             0x0A
> -#define ACPI_NHLT_BIG_LINEAR_2ELEMENT               0x0B
> -#define ACPI_NHLT_FIRST_GEOMETRY_LINEAR_4ELEMENT    0x0C
> -#define ACPI_NHLT_PLANAR_LSHAPED_4ELEMENT           0x0D
> -#define ACPI_NHLT_SECOND_GEOMETRY_LINEAR_4ELEMENT   0x0E
> -#define ACPI_NHLT_VENDOR_DEFINED                    0x0F
> -#define ACPI_NHLT_ARRAY_TYPE_MASK                   0x0F
> -#define ACPI_NHLT_ARRAY_TYPE_EXT_MASK               0x10
> -
> -#define ACPI_NHLT_NO_EXTENSION                      0x0
> -#define ACPI_NHLT_MIC_SNR_SENSITIVITY_EXT           (1<<4)
> -
> -struct acpi_nhlt_vendor_mic_count {
> -       u8 microphone_count;
> -};
> -
> -struct acpi_nhlt_vendor_mic_config {
> -       u8 type;
> -       u8 panel;
> -       u16 speaker_position_distance;  /* mm */
> -       u16 horizontal_offset;  /* mm */
> -       u16 vertical_offset;    /* mm */
> -       u8 frequency_low_band;  /* 5*Hz */
> -       u8 frequency_high_band; /* 500*Hz */
> -       u16 direction_angle;    /* -180 - + 180 */
> -       u16 elevation_angle;    /* -180 - + 180 */
> -       u16 work_vertical_angle_begin;  /* -180 - + 180 with 2 deg step *=
/
> -       u16 work_vertical_angle_end;    /* -180 - + 180 with 2 deg step *=
/
> -       u16 work_horizontal_angle_begin;        /* -180 - + 180 with 2 de=
g step */
> -       u16 work_horizontal_angle_end;  /* -180 - + 180 with 2 deg step *=
/
> -};
> -
> -/* Values for Type field above */
> -
> -#define ACPI_NHLT_MIC_OMNIDIRECTIONAL       0
> -#define ACPI_NHLT_MIC_SUBCARDIOID           1
> -#define ACPI_NHLT_MIC_CARDIOID              2
> -#define ACPI_NHLT_MIC_SUPER_CARDIOID        3
> -#define ACPI_NHLT_MIC_HYPER_CARDIOID        4
> -#define ACPI_NHLT_MIC_8_SHAPED              5
> -#define ACPI_NHLT_MIC_RESERVED6             6  /* 6 is reserved */
> -#define ACPI_NHLT_MIC_VENDOR_DEFINED        7
> -#define ACPI_NHLT_MIC_RESERVED              8  /* 8 and above are reserv=
ed */
> -
> -/* Values for Panel field above */
> -
> -#define ACPI_NHLT_MIC_POSITION_TOP          0
> -#define ACPI_NHLT_MIC_POSITION_BOTTOM       1
> -#define ACPI_NHLT_MIC_POSITION_LEFT         2
> -#define ACPI_NHLT_MIC_POSITION_RIGHT        3
> -#define ACPI_NHLT_MIC_POSITION_FRONT        4
> -#define ACPI_NHLT_MIC_POSITION_BACK         5
> -#define ACPI_NHLT_MIC_POSITION_RESERVED     6  /* 6 and above are reserv=
ed */
> -
> -struct acpi_nhlt_vendor_mic_device_specific_config {
> -       struct acpi_nhlt_mic_device_specific_config mic_array_device_conf=
ig;
> -       u8 number_of_microphones;
> -       struct acpi_nhlt_vendor_mic_config mic_config[];        /* Indexe=
d by number_of_microphones */
> -};
> -
> -/* Microphone SNR and Sensitivity extension */
> -
> -struct acpi_nhlt_mic_snr_sensitivity_extension {
> -       u32 SNR;
> -       u32 sensitivity;
> -};
> -
> -/* Render device with feedback */
> -
> -struct acpi_nhlt_render_feedback_device_specific_config {
> -       u8 feedback_virtual_slot;       /* Render slot in case of capture=
 */
> -       u16 feedback_channels;  /* Informative only */
> -       u16 feedback_valid_bits_per_sample;
> -};
> -
> -/* Non documented structures */
> -
> -struct acpi_nhlt_device_info_count {
> -       u8 structure_count;
> -};
> -
> -struct acpi_nhlt_device_info {
> -       u8 device_id[16];
> -       u8 device_instance_id;
> -       u8 device_port_id;
> -};
> -
>  /***********************************************************************=
********
>   *
>   * NHLT - Non HDAudio Link Table
> --
> 2.25.1
>

